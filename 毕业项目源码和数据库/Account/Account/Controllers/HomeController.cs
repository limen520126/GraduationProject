using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account.Models;

namespace Account.Controllers
{
    public class HomeController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        public ActionResult Index()
        {
            List<Departments> dList = db.Departments.ToList();
            ViewData["dList"] = dList;
            ViewBag.dBagList = dList;
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }


        public ActionResult Login() {
            return View();
        }
        [HttpPost]
        public ActionResult Login(string Account,string Pwd)
        {
            //根据账号和密码去判断是否存在 用户
            UserInfos user = db.UserInfos.Where(p => p.Account == Account && p.Pwd == Pwd).SingleOrDefault();
            //存在，登录成功
            if (user!=null)
            {
                //将当前登录的用户信息存储到Session中
                Session["user"] = user;
                ////定义Hashset存储 用户对应的菜单信息 原因：Hashset去重
                //方法一：HashSet去重
                HashSet<Menus> menusList = new HashSet<Menus>();
                //循环当前用户对应的角色集合
                foreach (var rurList in user.R_User_Roles)
                {
                    //循环角色对应的菜单集合
                    foreach (var rrmList in rurList.Roles.R_Role_Menus)
                    {
                        //将菜单对象添加到hashset集合中
                        menusList.Add(rrmList.Menus);
                    }
                }
                //方法二：视图。 Linq里的 Distinct()去重  或者  数据库中创建视图时Distinct去重
                List<v_User_Role_Menu> vmenusList = db.v_User_Role_Menu.Where(p => p.UserID == user.ID).Distinct().ToList();
                //create view v_User_Role_Menu
                //as
                //select rur.UserID,m.ID,m.Name,m.Remark,m.Url,m.Pid
                // from R_User_Roles rur, R_Role_Menus rrm,Menus m
                //where rur.RoleID = rrm.RoleID and rrm.MenuID = m.ID
                //go
                List<v_user_menus> vList = db.v_user_menus.Where(p => p.UserID == user.ID).ToList();
                //create view v_user_menus
                //as
                //select distinct rur.UserID,m.ID,m.Name,m.Remark,m.Url,m.Pid
                // from R_User_Roles rur, R_Role_Menus rrm,Menus m
                //where rur.RoleID = rrm.RoleID and rrm.MenuID = m.ID
                //go
                //将集合存储到session中
                Session["menusList"] = menusList;
                Session["vmenusList"] = vmenusList;
                Session["vList"] = vList;
                return RedirectToAction("Index");
            }
            else
            {
                //登录不成功的情况！
                return Content("<script>alert('账号或密码不正确！请重新输入！');history.go(-1);</script>");
            }
            
        }

        public ActionResult Exit() {
            //清空session
            Session["user"] = null;
            //Session.Clear();
            //跳转到登录
            return RedirectToAction("Login");
        }
    }
}