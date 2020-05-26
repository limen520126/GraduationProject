using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account.Models;

namespace Account.Controllers
{
    public class ExamLoginController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: ExamLogin
        public ActionResult Index()
        {
            return View();
        }


        public ActionResult StudentLogin() {
            return View();
        }

        [HttpPost]
        public ActionResult StudentLogin(string StuLoginName,string StuLoginPwd)
        {
            Student stu = db.Student.SingleOrDefault(p => p.StuLoginName == StuLoginName && p.StuLoginPwd == StuLoginPwd);
            if (stu != null)
            {
                Session["Student"] = stu;
                return RedirectToAction("Index");
            }
            else
            {
                ModelState.AddModelError("flag", "用户名或账号输入错误");
                return View();
            }
            
        }
        public ActionResult TeacherLogin() {
            return View();
        }
        [HttpPost]
        public ActionResult TeacherLogin(string TeacherLoginName,string TeacherLoginPwd)
        {
          Teacher tea =  db.Teacher.SingleOrDefault(p => p.TeacherLoginName == TeacherLoginName && p.TeacherLoginPwd == TeacherLoginPwd);
            if (tea!=null)
            {
                Session["Teacher"] = tea;
                return RedirectToAction("Index");
            }
            else
            {
                ModelState.AddModelError("flag", "用户名或账号输入错误");
                return View();
            }
            
        }

        public ActionResult Logout() {
            Session.Clear();
            return RedirectToAction("Index");
        }

        public ActionResult AjaxLogin() {
            return View();
        }

        /// <summary>
        /// ajax验证我们的登录账号是否存在
        /// </summary>
        /// <param name="LoginName"></param>
        /// <returns></returns>
        [HttpPost]
        public string CheckLoginName(string LoginName) {
           Student stu =  db.Student.FirstOrDefault(p => p.StuLoginName == LoginName);
            if (stu==null)
            {
                return "false";
            }
            else
            {
                return "true";
            }
        }

    }
}