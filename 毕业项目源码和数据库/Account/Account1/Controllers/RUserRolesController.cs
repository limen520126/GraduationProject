using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account1.Models;

namespace Account1.Controllers
{
    public class RUserRolesController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: RUserRoles
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult DelRoles(int? RUserRolesID) {
            //获取删除的对象
           R_User_Roles rur = db.R_User_Roles.Find(RUserRolesID);
            //EF remove删除对象
            db.R_User_Roles.Remove(rur);
            //从数据库中删除
            db.SaveChanges();

            return RedirectToAction("Index", "UserInfo");
        }

        public ActionResult SetRoles(int UserID) {
            //通过用户ID查到用户信息，并存ViewBag中
            UserInfos user = db.UserInfos.Find(UserID);
            ViewBag.User = user;
            //通过用户ID查到用户对应的角色关系，并存ViewBag中
            List<R_User_Roles> rURList = db.R_User_Roles.Where(p => p.UserID == UserID).ToList() ;
            ViewBag.rURList = rURList;
            //获得所有的角色，并存ViewBag中
            List<Roles> rList = db.Roles.ToList();
            ViewBag.rList = rList;

            return View();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="UserID">获得视图中的用户ID</param>
        /// <param name="roles">获得选中的角色ID</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult SetRoles(int UserID,List<int> roles)
        {
            //先通过用户ID去清除所有与该用户相关的角色关系
            var rURList = db.R_User_Roles.Where(p => p.UserID == UserID);
            foreach (var rUR in rURList)
            {
                db.R_User_Roles.Remove(rUR);
            }
            db.SaveChanges();

            if (roles!=null)
            {
                //添加新的角色关系
                foreach (var roleID in roles)
                {
                    //角色ID和用户ID组成新的R_User_Roles对象，添加到上下文对应R_User_Roles的集合中
                    R_User_Roles rur = new R_User_Roles()
                    {
                        UserID = UserID,
                        RoleID = roleID
                    };
                    db.R_User_Roles.Add(rur);
                }
                //保存到数据库中
                db.SaveChanges();
            }
            
            return RedirectToAction("Index", "UserInfo");
        }
    }
}