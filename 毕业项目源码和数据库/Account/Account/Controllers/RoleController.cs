using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account.Models;
using Account.Filter;

namespace Account.Controllers
{
    
    public class RoleController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: Role
        public ActionResult Index(string Name="")
        {
            //select * from Roles where 1=1
            List<Roles> list = db.Roles.Where(p=>Name==""||p.Name.Contains(Name)).ToList();
            ViewBag.Name = Name;
            return View(list);
        }

        [Login]
        public ActionResult Delete(int? id)
        {
            //根据角色id查角色菜单关系表，是否有菜单绑定
            var rrm = db.R_Role_Menus.Where(p => p.RoleID == id).ToList();
            //根据角色id查用户角色关系表,是否有用户绑定
            var rur = db.R_User_Roles.Where(p => p.RoleID == id).ToList();

            if (rrm.Count > 0)
            {
                return Content("<script>alert('撤除菜单绑定才可删除该角色！');history.go(-1);</script>");
            }else if (rur.Count>0)
            {
                return Content("<script>alert('撤除用户绑定才可删除该角色！');location.href='/Role/Index';</script>");
            }
            else
            {
                Roles role = db.Roles.Find(id);
                db.Roles.Remove(role);
                db.SaveChanges();
            }
            
            //跳转到首页index
            return RedirectToAction("index");


        }

        [Login]
        public ActionResult Add(Roles role)
        {
            if (ModelState.IsValid)
            {
                db.Roles.Add(role);
                db.SaveChanges();
            }
            return RedirectToAction("index", role);
        }
    }
}