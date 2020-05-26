using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account.Models;
using Account.Filter;

namespace Account.Controllers
{
    
    public class DepartmentController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: Department
        public ActionResult Index(string Name="")
        {
            
            List<Departments> list = db.Departments.Where(p=>Name==""||p.Name.Contains(Name)).ToList();
            ViewBag.Name = Name;
            ViewData["list"] = list;
            ViewBag.dList = list;
            return View(list);
        }


        
        [HttpPost]
        /// <summary>
        /// 保存
        /// </summary>
        /// <returns></returns>
        [Login]
        public ActionResult Add(Departments depart)
        {
            db.Departments.Add(depart);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

       
        public ActionResult edit(int id )
        {
            
            var depart = db.Departments.Find(id);
            return View(depart);
        }

        [HttpPost]
        public ActionResult edit(Departments depart)
        {
            //判断实体的状态是否是已修改
            db.Entry(depart).State = EntityState.Modified;
            //保存
            db.SaveChanges();

            return RedirectToAction("Index");
        }


        public ActionResult Delete(int? id)
        {
            //根据部门表id去查用户表中是否有该部门的人员
            var user = db.UserInfos.Where(p => p.DepartmentID == id).ToList();

            if (user.Count > 0)
            {
                return Content("<script>alert('该部门下已有成员！');location.href='/Department/Index';</script>");
            }
            else
            {
                Departments depart = db.Departments.Find(id);
                db.Departments.Remove(depart);
                db.SaveChanges();
            }
            //跳转到首页index
            return RedirectToAction("index");


        }
    }
}