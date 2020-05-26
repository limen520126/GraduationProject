using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account.Models;

namespace Account.Controllers
{
    public class MenuController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: Menu
        public ActionResult Index(string Name = "")
        {
            List<Menus> mList = db.Menus.Where(p => Name == ""|| p.Name.Contains(Name)).ToList();
            ViewBag.Name = Name;
            return View(mList);
        }

        public ActionResult Delete(int? id)
        {
            var rrm = db.R_Role_Menus.Where(p => p.MenuID == id).ToList();

            if (rrm.Count > 0)
            {
                return Content("<script>alert('该菜单已授权不可，不可删除，如果想清除该菜单的授权！');location.href='/Menu/Index';</script>");
            }
            else
            {
                Menus menus = db.Menus.Find(id);
                db.Menus.Remove(menus);
                db.SaveChanges();
            }
            //跳转到首页index
            return RedirectToAction("index");


        }

        /// <summary>
        /// 跳转到新增页面
        /// </summary>
        /// <returns></returns>
        public ActionResult Add()
        {
            return View();
        }
        [HttpPost]
        /// <summary>
        /// 保存
        /// </summary>
        /// <returns></returns>[]
        public ActionResult Add(Menus menu)
        {
            db.Menus.Add(menu);
            db.SaveChanges();
            return RedirectToAction("Index");
        }


        public ActionResult edit(int id)
        {
            var menu = db.Menus.Find(id);
            return View(menu);
        }

        [HttpPost]
        public ActionResult edit(Menus menu)
        {
            

            db.Entry(menu).State = EntityState.Modified;
            //保存
            db.SaveChanges();

            return RedirectToAction("Index");
        }
    }
}