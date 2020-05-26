using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account.Models;
using System.IO;
using System.Collections;
using System.Text;
using System.Data.Entity;
using Account.Filter;
namespace Account.Controllers
{
    [Login]
    public class UserController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        // GET: User
        /// <summary>
        /// 
        /// </summary>
        /// <param name="DepartmentID">部门ID</param>
        /// <param name="Name">用户名称</param>
        /// <param name="pageIndex">页面索引（当前页）</param>
        /// <param name="pageCount">每页显示行数</param>
        /// <returns></returns>
        public ActionResult Index(int DepartmentID = 0, string Name = "",int pageIndex = 1,int pageCount=5)
        {
            //查询部门信息，用于模糊查询的下拉框
            var departments = db.Departments.ToList();
            ViewBag.departments = departments;

            //获得记录总行数
            int totalCount = db.UserInfos.Where(p => (DepartmentID == 0 || p.DepartmentID == DepartmentID)
                ).Count();

            //根据总行数和每页显示行数计算总页数(Math.Ceiling向上取整)
            double totalPage = Math.Ceiling(totalCount / (double)pageCount);

            //两个条件，根据id排序，skip()跳过指定元素，返回剩下元素，Take（）从剩下的元素开头返回指定数量的连续元素
            var userinfos = db.UserInfos
                 .Where(p => (DepartmentID == 0 || p.DepartmentID == DepartmentID))
                 .OrderBy(p => p.ID).Skip((pageIndex-1)* pageCount).Take(pageCount)
                 .ToList();


            ViewBag.DepartmentID = DepartmentID;
            ViewBag.Name = Name;
            //当前页数
            ViewBag.pageIndex = pageIndex;
            //每页显示行数
            ViewBag.pageCount = pageCount;
            //总行数
            ViewBag.totalCount = totalCount;
            //总页数
            ViewBag.totalPage = totalPage;

            return View(userinfos);//返回视图，同时传递模型userinfos
        }

        public ActionResult Delete(int? id)
        {
            //根据这个ID查询对象，并且删除 EF lINQ
            //var userInfo = db.UserInfos.Where(p => p.ID == id).FirstOrDefault();
            if (id != null)
            {
                var userInfo = db.UserInfos.Find(id);
                db.UserInfos.Remove(userInfo);
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
            //部门列表
            var departments = db.Departments.ToList();
            ViewBag.departments = departments;

            //要给界面传值，角色列表
            var roles = db.Roles.ToList();
            ViewBag.roles = roles;
            return View();
        }
        [HttpPost]
        /// <summary>
        /// 保存 , HttpPostedFileBase upPhoto
        /// </summary>
        /// <returns></returns>[]
        public ActionResult Add(UserInfos userInfo, int[] roleIDS)
        {
            if (ModelState.IsValid)
            {
                ////处理图片
                //if (upPhoto != null)
                //{
                //    //1、获得文件的名称
                //    string fileName = Path.GetFileName(upPhoto.FileName);

                //    //2、判断文件是否是图片
                //    //string hz = Path.GetExtension(fileName); //.jpg
                //    if (fileName.EndsWith("jpg") || fileName.EndsWith("png")
                //        || fileName.EndsWith("gif") || fileName.EndsWith("jpeg"))
                //    {
                //        //3、保存图片到项目文件夹当中
                //        upPhoto.SaveAs(Server.MapPath("~/Content/images/users/" + fileName));
                //        //4、将图片文件名，绑定到该用户的photo字段中
                //        userInfo.Photo = fileName;
                //    }
                //    else
                //    {
                //        return Content("<script>alert('上传的文件必须是图片！')</script>");
                //    }
                //}
                //else
                //{
                //    return Content("<script>alert('未获取上传的文件')</script>");
                //}

                db.UserInfos.Add(userInfo);
                //保存
                db.SaveChanges();
                //同时保存该用户和角色的对应关系(多个) R_User_Roles
                //怎么获取UserID     userInfo.ID
                ///循环你选择的角色ID的数组,没循环一次，就要插入一个关系R_User_Roles
                if (roleIDS!=null)
                {
                    foreach (var roleid in roleIDS)
                    {
                        R_User_Roles r_User_Roles = new R_User_Roles()

                        {
                            UserID = userInfo.ID,
                            RoleID = roleid
                        };
                        db.R_User_Roles.Add(r_User_Roles);

                    }
                }
                
                db.SaveChanges();
                //R_User_Roles添加多条记录
                return RedirectToAction("Index");
            }
            else
            {
                return RedirectToAction("Add");
            }
            
        }

        /// <summary>
        /// get请求的添加方法：用于跳转到添加界面
        /// </summary>
        /// <returns></returns>
        public ActionResult Add1()
        {
            return View();
        }
        /// <summary>
        /// post请求的添加方法, HttpPostedFileBase upPhoto
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Add1(UserInfos user)
        {
            if (ModelState.IsValid)
            {
                //处理图片
                //if (upPhoto != null)
                //{
                //    //1、获得文件的名称
                //    string fileName = Path.GetFileName(upPhoto.FileName);

                //    //2、判断文件是否是图片
                //    //string hz = Path.GetExtension(fileName); //.jpg
                //    if (fileName.EndsWith("jpg") || fileName.EndsWith("png")
                //        || fileName.EndsWith("gif") || fileName.EndsWith("jpeg"))
                //    {
                //        //3、保存图片到项目文件夹当中
                //        upPhoto.SaveAs(Server.MapPath("~/Content/images/users/" + fileName));
                //        //4、将图片文件名，绑定到该用户的photo字段中
                //        user.Photo = fileName;
                //    }
                //    else
                //    {
                //        ModelState.AddModelError("", "上传的文件必须是图片！");
                //        return View();
                //    }
                //}
                //else
                //{
                //    ModelState.AddModelError("", "未获取上传的文件");
                //    return View();
                   
                //}

                var userInfo = db.UserInfos.SingleOrDefault(p => p.Account == user.Account);
                if (userInfo==null)
                {
                    db.UserInfos.Add(user);
                    //保存
                    db.SaveChanges();

                    return RedirectToAction("Index");
                   
                }
                else
                {
                    ModelState.AddModelError("", "该账号在数据库中已存在！");
                    return View();
                }
                
                
            }
            else
            {
                return View();
            }
        }


        /// <summary>
        /// 设置角色，获得根据用户id获得用户信息
        /// 获得所有的角色集合
        /// 获得已选中的角色集合
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public ActionResult SetRole(int userID) {
            //获得根据用户id获得用户信息
            UserInfos user =  db.UserInfos.Find(userID);
            //获得所有角色
            List<Roles> roles = db.Roles.ToList();
            //获得当前用户已有的角色
            List<int>  RoleIDList =  db.R_User_Roles.Where(p => p.UserID == userID).Select(p => (int)p.RoleID).ToList();
            ViewBag.UserInfo = user;
            ViewBag.Roles = roles;
            ViewBag.RoleIDList = RoleIDList;
            return View();
        }
        [HttpPost]
        public ActionResult SetRole(int? userID,List<int> roleids)
        {
            //先删除该用户之前所有角色
           List< R_User_Roles> list = db.R_User_Roles.Where(p=>p.UserID== userID).ToList();
            if (list.Count>0)
            {
                foreach (var r_User_Roles in list)
                {
                    db.R_User_Roles.Remove(r_User_Roles);
                }
                db.SaveChanges();   
            }

            if (roleids!=null)
            {
                //再添加本次设置的角色，在关系表中添加记录
                foreach (var roleID in roleids)
                {
                    R_User_Roles rur = new R_User_Roles();
                    rur.RoleID = roleID;
                    rur.UserID = userID;
                    db.R_User_Roles.Add(rur);

                }
                db.SaveChanges();
            }
            
            return RedirectToAction("Index");
        }

        

        public ActionResult edit(int id) {
            var user = db.UserInfos.Find(id);
            ViewBag.departments = db.Departments.ToList();
            ViewBag.roles = db.Roles.ToList();
            return View(user);
        }
        /// <summary>
        /// , HttpPostedFileBase upPhoto
        /// </summary>
        /// <param name="userInfo"></param>
        /// <param name="roleIDS"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult edit(UserInfos userInfo,int[] roleIDS)
        {
            //if (upPhoto!=null)
            //{
            //    string fileName = Path.GetFileName(upPhoto.FileName);
            //    upPhoto.SaveAs(Server.MapPath("~/Content/images/users") + "/" + fileName);
            //    userInfo.Photo = fileName;
            //}

            db.Entry(userInfo).State = EntityState.Modified;
            //保存
            db.SaveChanges();


            //根据用户id先删除角色关系
           var roles =  db.R_User_Roles.Where(p => p.UserID == userInfo.ID).ToList();
            foreach (var item in roles)
            {
                db.R_User_Roles.Remove(item);
            }
            db.SaveChanges();

            //再添加角色关系
            foreach (var roleid in roleIDS)
            {
                R_User_Roles r_User_Roles = new R_User_Roles()

                {
                    UserID = userInfo.ID,
                    RoleID = roleid
                };
                db.R_User_Roles.Add(r_User_Roles);

            }
            db.SaveChanges();



            return RedirectToAction("Index");
        }

        /// <summary>
        /// 1,3,15,16  [1,3,15,16]
        /// </summary>
        /// <returns></returns>
        public ActionResult deleteAll() {
            ArrayList arr = new ArrayList();
            string rkeyStr = "";
            StringBuilder sb = new StringBuilder();
            if (Request["delItems"] != null && Request["delItems"].ToString() != "")
            {
                rkeyStr = Request["delItems"].ToString();
                string[] rkeyArr = rkeyStr.Split(',');
                int count = 0;
                for (int i = 0; i < rkeyArr.Length; i++)
                {
                    int value = int.Parse(rkeyArr[i]);
                    var R_user = db.R_User_Roles.Where(p => p.UserID == value).ToList();

                    if (R_user.Count>0)
                    {
                        string str = "该用户已设置角色，不可删除，如果想删除该用户请清除该用户的角色设置！";
                        return Content(str);
                    }
                    else
                    {
                        UserInfos user = db.UserInfos.Find(int.Parse(rkeyArr[i]));
                        db.UserInfos.Remove(user);
                    }
                   
                }
                count = db.SaveChanges();
                if (count > 0)
                {
                    string str = "批量删除成功！";
                    return Content(str);
                }
            }
            else
            {
                rkeyStr = "";
                string str = "批量删除失败！";
                return Content(str);
            }
            return null;
        }

    }
}