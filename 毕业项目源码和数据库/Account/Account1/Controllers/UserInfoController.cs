using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Account1.Models;
using System.IO;

namespace Account1.Controllers
{
    public class UserInfoController : Controller
    {
        AccountDBEntities db = new AccountDBEntities();
        /// <summary>
        /// 查询
        /// </summary>
        /// <param name="departmentId">部门条件查询</param>
        /// <param name="Name">用户姓名模糊查询</param>
        /// <param name="pageIndex">当前页</param>
        /// <param name="pageCount">每页显示行数</param>
        /// <returns></returns>
        public ActionResult Index(int departmentId=0,string Name="",int pageIndex=1,int pageCount=5)
        {
            //获得部门集合
           List<Departments> dlist = db.Departments.ToList();
            //获得得总行数
            int totalCount = db.UserInfos.OrderBy(p => p.ID)
                .Where(p => (departmentId == 0 || p.DepartmentID == departmentId) && (Name == "" || p.Name.Contains(Name)))
                .Count();
            //获得总页数Ceiling向上取整 11/5  2.2  3 
            double tatolPage = Math.Ceiling((double)totalCount / pageCount);

            //获得用户集合，分页查询Skip()跳过指定数量的集合,
            //Take(),从Skip过滤后返回的集合中再从第一行取出指定的行数
            List<UserInfos> ulist =  db.UserInfos.OrderBy(p=>p.ID)
                .Where(p=>(departmentId==0||p.DepartmentID==departmentId)&&(Name==""||p.Name.Contains(Name)))
                .Skip((pageIndex-1)* pageCount).Take(pageCount)
                .ToList();
            //将部门集合存储到viewbag中
            ViewBag.dlist = dlist;
            ViewBag.departmentId = departmentId;
            ViewBag.Name = Name;

            //将这四个值通过Viewbag存储传输到视图中
            //当前页
            ViewBag.pageIndex = pageIndex;
            //每页显示行数
            ViewBag.pageCount = pageCount;
            //总行数
            ViewBag.totalCount = totalCount;
            //总页数
            ViewBag.tatolPage = tatolPage;

            //通过model将值传递到视图中
            return View(ulist);
        }

        /// <summary>
        /// 跳转到添加页面
        /// </summary>
        /// <returns></returns>
        public ActionResult AddUser()
        {
            //获得所有的部门
           ViewBag.Departments= db.Departments.ToList();
            //获得所有的角色
            ViewBag.Roles = db.Roles.ToList();
            return View();
        }
        /// <summary>
        /// 添加用户
        /// </summary>
        /// <param name="user">用户的信息</param>
        /// <param name="Photo">获得上传的图片</param>
        /// <param name="roles">获得选中的角色</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult AddUser(UserInfos user,HttpPostedFileBase Photo, int[] roles)
        {
            //处理图片
            if (Photo!=null)
            {
                //1、获得文件的名称
                string fileName = Path.GetFileName(Photo.FileName);

                //2、判断文件是否是图片
                //string hz = Path.GetExtension(fileName); //.jpg
                if (fileName.EndsWith("jpg") || fileName.EndsWith("png")
                    || fileName.EndsWith("gif") || fileName.EndsWith("jpeg"))
                {
                    //3、保存图片到项目文件夹当中
                    Photo.SaveAs(Server.MapPath("~/Content/images/users/" + fileName));
                    //4、将图片文件名，绑定到该用户的photo字段中
                    user.Photo = fileName;
                }
                else
                {
                    return Content("<script>alert('上传的文件必须是图片！')</script>");
                }
            }
            else
            {
                return Content("<script>alert('未获取上传的文件')</script>");
            }
            //添加用户
            db.UserInfos.Add(user);
            db.SaveChanges();

            //添加用户与角色的关系
            foreach (var roleID in roles)
            {
                R_User_Roles rur = new R_User_Roles();
                rur.RoleID = roleID;
                rur.UserID = user.ID;
                db.R_User_Roles.Add(rur);
            }
            db.SaveChanges();

            return RedirectToAction("Index");
        }

        public ActionResult Edit(int UserID)
        {
            //获得用户信息
            ViewBag.User = db.UserInfos.Find(UserID);
            //获得所有的部门
            ViewBag.Departments = db.Departments.ToList();
            //获得所有的角色
            ViewBag.Roles = db.Roles.ToList();
            //获得用户绑定的角色关系列表
            ViewBag.Rur = db.R_User_Roles.Where(p => p.UserID == UserID).ToList();
            return View();
        }

        [HttpPost]
        public ActionResult Edit(UserInfos user, HttpPostedFileBase EPhoto, int[] roles)
        {
            //一、如果EPhoto不为空就处理图片，替换user里的原来的图片，否则就不处理图片保留原来的图片
            if (EPhoto!=null)
            {
                //1、获得文件的名称
                string fileName = Path.GetFileName(EPhoto.FileName);
                //2、判断文件是否是图片
                if (fileName.EndsWith("jpg") || fileName.EndsWith("png")
                    || fileName.EndsWith("gif") || fileName.EndsWith("jpeg"))
                {
                    //3、保存图片到项目文件夹当中
                    EPhoto.SaveAs(Server.MapPath("~/Content/images/users/" + fileName));
                    //4、将图片文件名，绑定到该用户的photo字段中
                    user.Photo = fileName;
                }
            }
            //二、修改用户信息，该用户的各项属性的值已标记为已被修改，则全部进行修改
            db.Entry(user).State = System.Data.Entity.EntityState.Modified;
            db.SaveChanges();//保存到数据库中
            //三、修改用户与角色的关系
            //先通过用户ID去清除所有与该用户相关的角色关系
            var rURList = db.R_User_Roles.Where(p => p.UserID == user.ID);
            foreach (var rUR in rURList)
            {
                db.R_User_Roles.Remove(rUR);
            }
            db.SaveChanges();
            //添加新的角色关系
            foreach (var roleID in roles)
            {
                //角色ID和用户ID组成新的R_User_Roles对象，添加到上下文对应R_User_Roles的集合中
                R_User_Roles rur = new R_User_Roles()
                {
                    UserID = user.ID,
                    RoleID = roleID
                };
                db.R_User_Roles.Add(rur);
            }
            //保存到数据库中
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult Remove(int UserID) {
            //查询用户是否绑定了角色
            List<R_User_Roles> list = db.R_User_Roles.Where(p => p.UserID == UserID).ToList();
            if (list.Count>0)
            {
                //提示
                return Content("<script>alert('请解除该用户的角色绑定，再删除该用户');history.go(-1);</script>");
            }
            else
            {
                //根据用户id查找对象，移除用户
               var user =  db.UserInfos.Find(UserID);
                db.UserInfos.Remove(user);
                db.SaveChanges();
            }
            return RedirectToAction("Index");
        }
    }
}