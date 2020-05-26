using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account.Models;
namespace Account.Controllers
{
    public class RRoleMenuController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: RRoleMenu
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Delete(int? id)
        {
            if (id != null)
            {
                R_Role_Menus rrm = db.R_Role_Menus.Find(id);
                db.R_Role_Menus.Remove(rrm);
                db.SaveChanges();
            }

            return RedirectToAction("Index", "Role");
        }

        public ActionResult SetMenu(int roleID)
        {
          //查询角色对象
            Roles role = db.Roles.Find(roleID);
            //所有菜单
            List<Menus> menus = db.Menus.ToList();

            //获得角色所对应的菜单
            List<R_Role_Menus> selectedMenu = db.R_Role_Menus.Where(p=>p.RoleID==roleID).ToList();
            ViewBag.Role = role;
            ViewBag.Menus = menus;
            ViewBag.SelectedMenu = selectedMenu;
            return View();
        }
        [HttpPost]
        public ActionResult SetMenu(int? roleID, List<int> menuids)
        {
            //先删除该用户之前所有角色
            List<R_Role_Menus> list = db.R_Role_Menus.Where(p => p.RoleID == roleID).ToList();
            if (list.Count > 0)
            {
                foreach (var rrm in list)
                {
                    db.R_Role_Menus.Remove(rrm);
                }
                db.SaveChanges();
            }

            if (menuids!=null)
            {
                //再添加本次设置的角色，在关系表中添加记录
                foreach (var menuId in menuids)
                {
                    R_Role_Menus rrm = new R_Role_Menus();
                    rrm.RoleID = roleID;
                    rrm.MenuID = menuId;
                    db.R_Role_Menus.Add(rrm);

                }
                db.SaveChanges();
            }
           
            return RedirectToAction("Index", "Role");
        }
    }
}