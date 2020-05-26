using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account1.Models;

namespace Account1.Controllers
{
    public class MenuController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: Menu
        public ActionResult Index(string Name="")
        {
            List<Menus> list = db.Menus.Where(p=> Name ==""|| p.Name.Contains(Name)).ToList();
            ViewBag.Name = Name;
            return View(list);
        }

        public ActionResult Add()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Add(Menus menus)
        {
            db.Menus.Add(menus);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult Edit(int id)
        {
            Menus menus = db.Menus.Find(id);
            //Menus menus1 = db.Menus.Where(p => p.ID == id).SingleOrDefault();
            //Menus menus2 = db.Menus.SingleOrDefault(p => p.ID == id);
            return View(menus);
        }

        [HttpPost]
        public ActionResult Edit(Menus menus)
        {
            db.Entry(menus).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult Delete(int id)
        {
            List<R_Role_Menus> rlist = db.R_Role_Menus.Where(p => p.MenuID == id).ToList();
            if (rlist.Count>0)
            {
                return Content("<script>alert('请解除该菜单的角色绑定，再删除该菜单');history.go(-1);</script>");
            }
            Menus menus = db.Menus.Find(id);
            db.Menus.Remove(menus);
            db.SaveChanges();
            return  RedirectToAction("Index");
        }
    }
}