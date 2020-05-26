using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account.Models;
namespace Account.Controllers
{
    public class RUserRoleController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: RUserRole
        public ActionResult Index()
        {
            return View();
        }
        /// <summary>
        /// 根据关系表的id删除角色与用户的关系
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Delete(int? id) {
            if (id!=null)
            {
                R_User_Roles r_User_Roles = db.R_User_Roles.Find(id);
                db.R_User_Roles.Remove(r_User_Roles);
                db.SaveChanges();
            }
           
            return RedirectToAction("Index", "User");
        }
    }
}