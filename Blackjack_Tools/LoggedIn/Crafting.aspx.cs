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

namespace Blackjack_Tools
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void GridView_Crafting_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
                string commandName = e.CommandName.ToString();

                switch (commandName)
                {
                    //Cancel a request
                    #region CancelArgument
                    case "Cancel":
                        using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                        {
                            using (SqlCommand cmd = new SqlCommand("Cancel_CraftingRequest", con))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.Add("@Request_ID", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[7].Text);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();

                            }
                        }
                        Response.Redirect(Request.RawUrl);
                        break;
                    #endregion
                    //Check out a job
                    #region EditArgument
                    case "Edit":
                        using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                        {
                            using (SqlCommand cmd = new SqlCommand("Check_slash_fulfill_Crafting", con))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.Add("@Check_User", SqlDbType.UniqueIdentifier).Value = new Guid(Session["UserID"].ToString());
                                cmd.Parameters.Add("@Request_ID", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[7].Text);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();

                            }
                        }
                        Response.Redirect(Request.RawUrl);
                        break;
                    #endregion
                    //Fulfill a job
                    #region UpdateArgument
                    case "Update":
                        using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                        {
                            using (SqlCommand cmd = new SqlCommand("Check_slash_fulfill_Crafting", con))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.Add("@Check_User", SqlDbType.UniqueIdentifier).Value = new Guid(Session["UserID"].ToString());
                                cmd.Parameters.Add("@Request_ID", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[7].Text);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();

                            }
                        }
                        Response.Redirect(Request.RawUrl);
                        break;
                    #endregion
                    // Drop a job
                    #region DeleteArgument
                    case "Delete":
                        using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE CraftingRequests_DB SET CheckedOutBy_User_ID = NULL, Date_CheckedOut = NULL WHERE (Request_ID = @Request_ID)", con))
                            {
                                cmd.CommandType = CommandType.Text;
                                cmd.Parameters.Add("@Request_ID", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[7].Text);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();

                            }
                        }
                        Response.Redirect(Request.RawUrl);
                        break;
                    #endregion


                }
            }
            catch { }
 
        }

        protected void GridView_Crafting_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                string requester = (string)DataBinder.Eval(e.Row.DataItem, "Requester_Name");
                int rewardID = (int)DataBinder.Eval(e.Row.DataItem, "RewardID");
                string rewardName = (string)DataBinder.Eval(e.Row.DataItem, "RewardName");
                HyperLink hpl_CheckedUser = (HyperLink)e.Row.Cells[6].FindControl("hpl_CheckedOutBy");
                Image img_Reward = (Image)e.Row.Cells[4].FindControl("img_Reward");
                Image img_Info = (Image)e.Row.Cells[6].FindControl("img_Info");
                Image img_CFlair = (Image)e.Row.Cells[6].FindControl("img_CFlair");
                Image img_RFlair = (Image)e.Row.Cells[0].FindControl("img_RFlair");
                ImageButton imgB_Cancel = (ImageButton)e.Row.Cells[8].FindControl("imgB_Cancel");
                ImageButton imgB_Checkout = (ImageButton)e.Row.Cells[8].FindControl("imgB_Checkout");
                ImageButton imgB_Drop = (ImageButton)e.Row.Cells[8].FindControl("imgB_Drop");
                ImageButton imgB_Fulfill = (ImageButton)e.Row.Cells[8].FindControl("imgB_Fulfill");
                imgB_Cancel.Visible = false;
                imgB_Checkout.Visible = false;
                imgB_Drop.Visible = false;
                imgB_Fulfill.Visible = false;
                if (hpl_CheckedUser.Text == "") // hide the date display icon if the job has not been checked out
                    img_Info.Visible = false;
                
                switch (rewardID)
                {
                    case 1:
                        img_Reward.ImageUrl = "~/Resources/gil.png";
                        img_Reward.ToolTip = rewardName;
                        break;

                    case 2:
                        img_Reward.ImageUrl = "~/Resources/shard.png";
                        img_Reward.ToolTip = rewardName;
                        break;
                }

                try
                {
                    int checkFulfilledCount = (int)DataBinder.Eval(e.Row.DataItem, "Check_Fulfilled");
                    if (checkFulfilledCount >= 3)
                    {
                        img_CFlair.ImageUrl = "~/Resources/Flair/rsz_b_test1.png";
                        if (checkFulfilledCount >= 6)
                        {
                            img_CFlair.ImageUrl = "~/Resources/Flair/rsz_s_test1.png";
                        }
                    }
                }
                catch { }

                try
                {
                    int requesterFulfilledCount = (int)DataBinder.Eval(e.Row.DataItem, "Request_Fulfilled");
                    if (requesterFulfilledCount >= 3)
                    {
                        img_RFlair.ImageUrl = "~/Resources/Flair/rsz_b_test1.png";
                        if (requesterFulfilledCount >= 6)
                        {
                            img_RFlair.ImageUrl = "~/Resources/Flair/rsz_s_test1.png";
                        }
                    }
                }
                catch { }

                try
                {
                    if (Session["UserName"].ToString() == requester && hpl_CheckedUser.Text == "") //If user IS the requester and the request IS NOT checked out
                        imgB_Cancel.Visible = true; //Allow them to drop it
                    else
                        if (Session["UserName"].ToString() != requester && hpl_CheckedUser.Text == "") //If user IS NOT the requester and the request IS NOT checked out
                            imgB_Checkout.Visible = true; //Allow them to check out the job
                        else
                            if (Session["UserName"].ToString() == hpl_CheckedUser.Text) // If the job is checked out and the user is the person who checked out the job
                            {
                                imgB_Drop.Visible = true; // Allow them to drop the job or fulfill it
                                imgB_Fulfill.Visible = true;
                            }

                }
                catch { }
            }
        }

        protected void GridView_CraftingFulfilled_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string requester = (string)DataBinder.Eval(e.Row.DataItem, "Requester_Name");
                int rewardID = (int)DataBinder.Eval(e.Row.DataItem, "RewardID");
                string rewardName = (string)DataBinder.Eval(e.Row.DataItem, "RewardName");
                Image img_RFlair = (Image)e.Row.Cells[0].FindControl("img_RFlair");
                Image img_CFlair = (Image)e.Row.Cells[6].FindControl("img_CFlair");
                Image img_Reward = (Image)e.Row.Cells[4].FindControl("img_Reward");
                bool verified = (bool)DataBinder.Eval(e.Row.DataItem, "Verified");

                ImageButton imgB_Verify = (ImageButton)e.Row.Cells[10].FindControl("imgB_Verify");
                imgB_Verify.Visible = false;

                switch (rewardID)
                {
                    case 1:
                        img_Reward.ImageUrl = "~/Resources/gil.png";
                        img_Reward.ToolTip = rewardName;
                        break;

                    case 2:
                        img_Reward.ImageUrl = "~/Resources/shard.png";
                        img_Reward.ToolTip = rewardName;
                        break;
                }

                try
                {
                    int checkFulfilledCount = (int)DataBinder.Eval(e.Row.DataItem, "Check_Fulfilled");
                    if (checkFulfilledCount >= 3)
                    {
                        img_CFlair.ImageUrl = "~/Resources/Flair/rsz_b_test1.png";
                        if (checkFulfilledCount >= 6)
                        {
                            img_CFlair.ImageUrl = "~/Resources/Flair/rsz_s_test1.png";
                        }
                    }
                }
                catch { }

                try
                {
                    int requesterFulfilledCount = (int)DataBinder.Eval(e.Row.DataItem, "Request_Fulfilled");
                    if (requesterFulfilledCount >= 3)
                    {
                        img_RFlair.ImageUrl = "~/Resources/Flair/rsz_b_test1.png";
                        if (requesterFulfilledCount >= 6)
                        {
                            img_RFlair.ImageUrl = "~/Resources/Flair/rsz_s_test1.png";
                        }
                    }
                }
                catch { }

                if (Session["UserName"].ToString() == requester && verified == false) // If the user IS the requester and the job is not already verified
                    imgB_Verify.Visible = true; //Allow them to verify the job
            }
        }

        protected void GridView_CraftingFulfilled_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
                string commandName = e.CommandName.ToString();

                switch (commandName)
                {
                    case "Update":
                        using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE CraftingRequests_DB SET Verified = 1, Date_Verified = GETDATE() WHERE (Request_ID = @Request_ID)", con))
                            {
                                cmd.CommandType = CommandType.Text;
                                cmd.Parameters.Add("@Request_ID", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[9].Text);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();

                            }
                        }
                        Session["CraftingCollapse"] = "false"; //Tell the program not to collapse the panel on pageload
                        Response.Redirect(Request.RawUrl);
                        break;
                }
            }
            catch { }
        }

        protected void pnl_CraftingFulfilled_Body_PreRender(object sender, EventArgs e)
        {
            this.pnl_CraftingFulfilled_Body_CollapsiblePanelExtender.Collapsed = true; // By default, collapse the panel, BUT
            //If the user just verified a record, don't collapse the panel
            try
            {
                if ((string)Session["CraftingCollapse"] == "false")
                {
                    this.pnl_CraftingFulfilled_Body_CollapsiblePanelExtender.Collapsed = false;
                    Session.Remove("CraftingCollapse");
                }
            }
            catch { }
        }

    }
}
