using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Data.SqlTypes;
using System.Data.OleDb;
using System.Web.Configuration;


namespace Blackjack_Tools.Admin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.IsInRole("Admin") != true)
                Response.Redirect("~/Default.aspx");
            Session["ApplicationName"] = "BlackjackTools";
        }

        #region AdminUsers
        //Gridview Population
        protected void GrdV_Users_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                bool userlocked = (bool)DataBinder.Eval(e.Row.DataItem, "IsLockedOut");
                string roleparameter = (string)DataBinder.Eval(e.Row.DataItem, "UserName");
                ImageButton imgB_UnlockUser = (ImageButton)e.Row.Cells[9].FindControl("imgB_UnlockUser");
                ImageButton imgB_AddComment = (ImageButton)e.Row.Cells[9].FindControl("imgB_AddComment");
                ImageButton imgB_AddToRole = (ImageButton)e.Row.Cells[9].FindControl("imgB_AddToRole");
                ImageButton imgB_RemoveFromRole = (ImageButton)e.Row.Cells[9].FindControl("imgB_RemoveFromRole");
                Panel pnl_RolesDisplay = (Panel)e.Row.Cells[4].FindControl("pnl_RolesDisplay");
                using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT aspnet_Roles.RoleName FROM aspnet_Users INNER JOIN aspnet_UsersInRoles ON aspnet_Users.UserId = aspnet_UsersInRoles.UserId"
                        + " INNER JOIN aspnet_Roles ON aspnet_UsersInRoles.RoleId = aspnet_Roles.RoleId WHERE (aspnet_Users.UserName = @UserName)", con))
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.Parameters.Add("@UserName", SqlDbType.NVarChar).Value = roleparameter;
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            ReadSingleRow((IDataRecord)reader, pnl_RolesDisplay);
                        }
                        cmd.Parameters.Clear();
                        reader.Close();
                    }
                }
                if (userlocked == false)
                    imgB_UnlockUser.Visible = false;
                if (pnl_RolesDisplay.Controls.Count.Equals(1))
                    imgB_RemoveFromRole.Visible = false;
                if (roleparameter.ToLower() == User.Identity.Name.ToLower())
                {
                    imgB_UnlockUser.Visible = false;
                    imgB_AddComment.Visible = false;
                    imgB_AddToRole.Visible = false;
                    imgB_RemoveFromRole.Visible = false;
                }
            }
        }
        private static void ReadSingleRow(IDataRecord reader, Panel panel)
        {
            Label item = new Label();
            item.Text = (string)reader[0] + Environment.NewLine;
            panel.Controls.Add((Control)item);

        }

        protected void GrdV_Users_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
                string commandName = e.CommandName.ToString();

                switch (commandName)
                {

                    //Unlock a User
                    #region UpdateArgument
                    case "Update":
                        using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                        {
                            using (SqlCommand cmd = new SqlCommand("aspnet_Membership_UnlockUser", con))
                            {
                                int index = (int)GrdV_Users.SelectedIndex;
                                try
                                {
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    cmd.Parameters.Add("@ApplicationName", SqlDbType.VarChar).Value = Session["ApplicationName"];
                                    cmd.Parameters.Add("@UserName", SqlDbType.VarChar).Value = row.Cells[0].Text.ToString();
                                    con.Open();
                                    cmd.ExecuteNonQuery();
                                    cmd.Parameters.Clear();
                                }
                                catch { }
                            }
                        }
                        Response.Redirect(Request.RawUrl);
                        break;
                    #endregion

                    //Add a comment
                    #region EditArgument
                    case "Edit":
                        using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                        {
                            using (SqlCommand cmd = new SqlCommand("aspnet_Membership_UpdateUser", con))
                            {
                                try
                                {
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    cmd.Parameters.Add("@ApplicationName", SqlDbType.NVarChar).Value = Session["ApplicationName"].ToString();
                                    cmd.Parameters.Add("@UserName", SqlDbType.NVarChar).Value = row.Cells[0].Text.ToString();
                                    cmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = row.Cells[6].Text.ToString();
                                    cmd.Parameters.Add("@Comment", SqlDbType.NVarChar).Value = txt_UserComment.Text.ToString();
                                    cmd.Parameters.Add("@IsApproved", SqlDbType.Bit).Value = 1;
                                    cmd.Parameters.Add("@LastLoginDate", SqlDbType.DateTime).Value = row.Cells[2].Text.ToString() + " 12:00:00";
                                    cmd.Parameters.Add("@LastActivityDate", SqlDbType.DateTime).Value = row.Cells[3].Text.ToString() + " 12:00:00";
                                    cmd.Parameters.Add("@UniqueEmail", SqlDbType.Int).Value = 0;
                                    cmd.Parameters.Add("@CurrentTimeUtc", SqlDbType.DateTime).Value = DateTime.UtcNow.ToString();
                                    con.Open();
                                    cmd.ExecuteNonQuery();
                                    cmd.Parameters.Clear();
                                }
                                catch { }
                            }
                        }
                        Response.Redirect(Request.RawUrl);
                        break;
                    #endregion

                    //Add a User to a Role
                    #region InsertArgument
                    case "Insert":
                        using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                        {
                            using (SqlCommand cmd = new SqlCommand("aspnet_UsersInRoles_AddUsersToRoles", con))
                            {
                                int index = (int)GrdV_Users.SelectedIndex;
                                try
                                {
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    cmd.Parameters.Add("@ApplicationName", SqlDbType.NVarChar).Value = Session["ApplicationName"];
                                    cmd.Parameters.Add("@UserNames", SqlDbType.NVarChar).Value = row.Cells[0].Text.ToString();
                                    cmd.Parameters.Add("@RoleNames", SqlDbType.NVarChar).Value = ddl_Roles.SelectedValue.ToString();
                                    con.Open();
                                    cmd.ExecuteNonQuery();
                                    cmd.Parameters.Clear();
                                }
                                catch { }
                            }
                        }
                        Response.Redirect(Request.RawUrl);
                        break;
                    #endregion

                    //Remove a User from a Role
                    #region DeleteArgument
                    case "Delete":
                        using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                        {
                            using (SqlCommand cmd = new SqlCommand("aspnet_UsersInRoles_RemoveUsersFromRoles", con))
                            {
                                int index = (int)GrdV_Users.SelectedIndex;
                                try
                                {
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    cmd.Parameters.Add("@ApplicationName", SqlDbType.NVarChar).Value = Session["ApplicationName"];
                                    cmd.Parameters.Add("@UserNames", SqlDbType.NVarChar).Value = row.Cells[0].Text.ToString();
                                    cmd.Parameters.Add("@RoleNames", SqlDbType.NVarChar).Value = ddl_Roles.SelectedValue.ToString();
                                    con.Open();
                                    cmd.ExecuteNonQuery();
                                    cmd.Parameters.Clear();
                                }
                                catch { }
                            }
                        }
                        Response.Redirect(Request.RawUrl);
                        break;
                    #endregion
                }

            }
            catch { }
        }
        #endregion

        protected void pnl_Users_Body_PreRender(object sender, EventArgs e)
        {
            this.pnl_Users_Body_CollapsiblePanelExtender.ExpandedSize = (int)this.GrdV_Users.Height.Value;
        }

        protected void pnl_DropDowns_Body_PreRender(object sender, EventArgs e)
        {
            int cHeight = (int)this.GridView_CraftedItems.Height.Value + (int)this.frmV_CraftedItems.Height.Value;
            int gHeight = (int)this.GridViewGatheredItems.Height.Value + (int)this.frmV_GatheredItems.Height.Value;

            if (cHeight >= gHeight)
                this.pnl_DropDowns_Body_CollapsiblePanelExtender.ExpandedSize = cHeight;
            else
                this.pnl_DropDowns_Body_CollapsiblePanelExtender.ExpandedSize = gHeight;
        }

        protected void btn_Flair_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                {
                    using (SqlCommand cmd = new SqlCommand("UpdateFulfilledCount", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                    }
                }
        }
    }
}
