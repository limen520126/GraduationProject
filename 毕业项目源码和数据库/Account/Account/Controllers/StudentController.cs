using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account.Models;

namespace Account.Controllers
{
    public class StudentController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: Student
        public ActionResult Index()
        {
           List<Student> sList= db.Student.ToList();
            ViewBag.sList = sList;
            //ViewData["sList"] = sList;
            //TempData["sList"] = sList;
            return View(sList);
        }

        public ActionResult Index2()
        {
            return View();
        }

        public ActionResult Edit(int id)
        {
            Student stu = db.Student.Find(id);
            //Student stu1 = db.Student.SingleOrDefault(p => p.StuID == id);
            //Student stu2 = db.Student.FirstOrDefault(p => p.StuID == id);
            //Student stu3 = db.Student.Where(p => p.StuID == id).SingleOrDefault();
            return View(stu);
        }

        public ActionResult Add()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Add(Student stu)
        {
            if (ModelState.IsValid)
            {//判断注册时填写的登录账号是否再数据库中已存在
                Student s = db.Student.SingleOrDefault(p => p.StuLoginName == stu.StuLoginName);
                if (s==null)
                {
                    db.Student.Add(stu);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                else
                {
                    ModelState.AddModelError("flag", "该账号已存在！");
                    return View();
                }
            }
            else
            {
                return View();
            }
            
        }
    }
}