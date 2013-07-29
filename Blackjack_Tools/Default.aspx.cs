using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data.SqlTypes;
using System.Data;

namespace Blackjack_Tools
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                {
                    using (SqlCommand cmd = new SqlCommand("Select UserName, UserID From aspnet_Users Where LoweredUserName = @LoweredName ", con))
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.Add("@LoweredName", SqlDbType.NVarChar).Value = User.Identity.Name.ToLower();
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        while (reader.Read())
                        {
                            Session["UserName"] = (string)reader[0];
                            Session["UserID"] = reader[1].ToString();
                        }
                        reader.Close();
                        cmd.Parameters.Clear();
                    }
                }
            }
            catch { }
            string currentfolder = HttpContext.Current.Request.Url.OriginalString;
            
            #region userbrowse
            try
            {
                if (currentfolder.Contains("/LoggedIn/default.aspx") && Request.QueryString["User"] != null)
                {
                    using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                    {
                        using (SqlCommand cmd = new SqlCommand("Select UserName, UserID From aspnet_Users Where LoweredUserName = @LoweredName ", con))
                        {
                            cmd.CommandType = CommandType.Text;
                            cmd.Parameters.Add("@LoweredName", SqlDbType.NVarChar).Value = Request.QueryString["User"].ToLower();
                            con.Open();
                            SqlDataReader reader = cmd.ExecuteReader();

                            while (reader.Read())
                            {
                                Session["CurrentlyViewedUserName"] = reader[0];
                                Session["CurrentlyViewedUserID"] = reader[1].ToString();                                
                            }
                            reader.Close();
                            cmd.Parameters.Clear();
                        }
                    }
                }
                else
                    Session["CurrentlyViewedUserID"] = Session["UserID"];
            }
            catch { }
            #endregion
            #region xivdb tooltips
            string csName = "xivdb tooltips";
            Type csType = this.GetType();
            // Get a ClientScriptManager reference from the Page class.
            ClientScriptManager cs = Page.ClientScript;

            // Check to see if the client script is already registered.
            if (!cs.IsClientScriptBlockRegistered(csType, csName))
            {
                StringBuilder csText = new StringBuilder();
                csText.Append(@"<script type=""text/javascript"" src=""/Scripts/fpop_min.js""></script>");
                cs.RegisterClientScriptBlock(csType, csName, csText.ToString());
            }
            #endregion
            #region role management
            try
            {
                if ((string)Session["PermissionsIssue"] == "true")
                {
                    pnl_PermissionsIssue.Visible = true;
                    Session.Remove("PermissionsIssue");
                }
            }
            catch { }
            try
            {
                if (currentfolder.Contains("/LoggedIn") || currentfolder.Contains("/Admin"))
                    if ((User.IsInRole("BlackjackMember") != true) && (User.IsInRole("Admin") != true))
                    {
                        Session["PermissionsIssue"] = "true";
                        Response.Redirect("~/Default.aspx");
                    }
            }
            catch 
            {
                    
            }
            
            #endregion
            #region Set Talk Back Labels
            try
            {
                if (Session["UserName"].ToString() != "")
                    lbl_UserName.Text = ", " + Session["UserName"].ToString();
            }
            catch { }
            try
            {
                if (Session["CurrentlyViewedUser"].ToString() == Session["UserName"].ToString())
                        lbl_User.Text = "Your ";
                else
                    lbl_User.Text = Session["CurrentlyViewedUser"].ToString() + "\'s ";
            }
            catch { }
            #endregion
            #region refresh Calls
            //Gathering
            try
            {
                lbl_GatheringRefresh.Text = "Page Fetched at: " + DateTime.Now.ToLongTimeString();
            }
            catch { }
            //Crafting
            try
            {
                lbl_CraftingRefresh.Text = "Page Fetched at: " + DateTime.Now.ToLongTimeString();
            }
            catch { }
            #endregion

        }

    }
}
