using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account.Models;

namespace Account.Controllers
{
    public class AccountController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: Account
        public ActionResult Index()
        {
            UserInfos user = Session["user"] as UserInfos;
            List<Roles> roles = new List<Roles>() ;
            foreach (var rur in user.R_User_Roles)
            {
                roles.Add(rur.Roles);
            }
           
            
           
            return View(roles);
        }
    }
}