using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account.Models;
using PagedList;

namespace Account.Controllers
{
    public class AnswersController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: Answers
        /// <summary>
        /// 在线考试试卷
        /// </summary>
        /// <param name="PaperID"></param>
        /// <param name="StuID"></param>
        /// <returns></returns>
        public ActionResult Index(int PaperID, int StuID)
        {
           
            //根据学生的id和试卷id获得答题信息
            Answer answer = db.Answer.FirstOrDefault(a => a.PaperID == PaperID && a.StuID == StuID);
            return View(answer);
        }
        /// <summary>
        /// ajax异步请求，修改答题答案
        /// </summary>
        /// <param name="AnswerID"></param>
        /// <param name="TopicID"></param>
        /// <param name="DetailAnswer"></param>
        [HttpPost]
        public void Index(int AnswerID, int TopicID, string DetailAnswer)
        {
            //根据题号和学生作答记录查询学生在答题卡中的记录
            var result = db.Detail.FirstOrDefault(d => d.TopicID == TopicID && d.AnswerID == AnswerID);
            //修改成最新提交的答案
            result.DetailAnswer = DetailAnswer;
            db.SaveChanges();
           
        }
        /// <summary>
        /// 学生考试
        /// </summary>
        /// <param name="PaperID"></param>
        /// <param name="StuID"></param>
        /// <returns></returns>
        public ActionResult AnswerDetail(int PaperID, int StuID)
        {
            //第一步：填写答题信息
                //当点击“开始考试”时，往考试信息登记表中，添加该学生对应试卷的考试信息，初始化基础数据
                Answer an = new Answer()     //an.AnswerID = 5
                {//对象初始化器
                    PaperID = PaperID,  //试卷id
                    StuID = StuID,      //学生id
                    TeacherID = 1,      //老师id,默认是主键为1的老师
                    AnswerScore = 0,    //考试成绩，默认是0，老师审卷完才修改统分
                    AnswerTime = DateTime.Now,   //开始答题时间，默认系统时间
                    SubmitTime = null,           //学生点击提交试卷的时间，现默认为空
                    BatchTime = null,           //老师点击批改试卷的时间，现默认为空
                    AnswerState = 0             //0 考试中  1未审批  2已审批
                };
                db.Answer.Add(an);
                db.SaveChanges();

            //第二步：准备答题卡

                //查找试卷对应的所有题目
                List<Topic> tList = db.Topic.Where(t => t.PaperID == PaperID).ToList();

                foreach (var topic in tList)
                {
                    //每道题都在detail的答卷表中进行初始化（准备空白答题卡）
                    Detail detail = new Detail()
                    {
                        AnswerID = an.AnswerID,  //5
                        TopicID = topic.TopicID,  //1 2 3 4
                        DetailAnswer = "" //在这里初始化空答案，当点击提交时，
                        //修改对应的题的答案即可，便无需做添加，这样省去了做题状态的判断
                    };
                    db.Detail.Add(detail);//添加记录
                }
                db.SaveChanges();//统一提交保存
            //解决导航属性不能用的问题，做一个跨动作
            return RedirectToAction("Index", "Answers", new { PaperID = PaperID, StuID = StuID });
        }
        /// <summary>
        /// 交卷
        /// </summary>
        /// <param name="AnswerID"></param>
        /// <returns></returns>
        public ActionResult SubmitPaper(int AnswerID) {
            //根据AnswerID查到该考试
            Answer answer = db.Answer.Find(AnswerID);
            //修改考卷提交时间
            answer.SubmitTime = DateTime.Now;
            //修改状态，改为未审核
            answer.AnswerState = 1;
            //保存
            db.SaveChanges();

           return RedirectToAction("IndexStu", "Papers");
        }

        /// <summary>
        /// 老师的审卷列表
        /// </summary>
        /// <param name="page"></param>
        /// <returns></returns>
        public ActionResult TeAnswer(int? page=null) {

            List<Answer> list = db.Answer.OrderByDescending(p=>p.AnswerID).ToList();
            //第几页  
            int pageNumber = page ?? 1;

            
            //每页显示多少条  
            int pageSize = 5;

            //通过ToPagedList扩展方法进行分页  
            IPagedList<Answer> answerPagedList = list.ToPagedList(pageNumber, pageSize);

            return View(answerPagedList);
        }
    }
}