using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account.Models;

namespace Account.Controllers
{
    public class TeachersController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: Teachers
        public ActionResult Index()
        {
            List<Teacher> tList = db.Teacher.ToList();
            return View(tList);
        }

        public ActionResult Create() {
            return View();
        }
        [HttpPost]
        public ActionResult Create(Teacher tea)
        {
            if (ModelState.IsValid)
            {
                db.Teacher.Add(tea);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            else
            {
                return View();
            }
            
            
        }

        [HttpPost]
        public ActionResult AllDelete(string teachersID) {
            //定义数组用来存储 字符串中拆分的teacherID 
            string[] teaID = teachersID.Split(',');
            //循环数组，删除对应teacherID的老师信息
            for (int i = 0; i < teaID.Length; i++)
            {
                //判断循环获得的teaID每项中的值是否有空值
                if (teaID[i]!=null&& teaID[i].ToString()!="")
                {
                  int value = int.Parse(teaID[i]);
                  Teacher tea =   db.Teacher.Find(value);
                  db.Teacher.Remove(tea);
                }
            }
            //数据库中执行删除的记录数
            int count =  db.SaveChanges();
            if (count>0)
            {
                return Content("1");
            }
            else
            {
                return Content("0");
            }
            
        }
    }
}