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
using System.Text;


namespace Blackjack_Tools
{
    public partial class _Default : System.Web.UI.Page
    {
        #region OpenRequests

        protected void GrdV_CraftingRequests_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                int rewardID = (int)DataBinder.Eval(e.Row.DataItem, "RewardID");
                string rewardName = (string)DataBinder.Eval(e.Row.DataItem, "RewardName");
                Image img_Reward = (Image)e.Row.Cells[3].FindControl("img_Reward");
                Image img_Info = (Image)e.Row.Cells[5].FindControl("img_Info");
                ImageButton imgB_Cancel = (ImageButton)e.Row.Cells[7].FindControl("imgB_Cancel");
                imgB_Cancel.Visible = false;

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
                Image img_Flair = (Image)e.Row.Cells[5].FindControl("img_Flair");
                try
                {
                    int FulfilledCount = (int)DataBinder.Eval(e.Row.DataItem, "FulfilledCount");
                    if (FulfilledCount >= 3)
                    {
                        img_Flair.ImageUrl = "~/Resources/Flair/rsz_b_test1.png";
                        if (FulfilledCount >=6)
                            img_Flair.ImageUrl = "~/Resources/Flair/rsz_s_test1.png";
                    }

                }
                catch { }

                try 
                { 
                    string checkedoutby = (string)DataBinder.Eval(e.Row.DataItem, "CheckedOutBy_Name");
                    if (checkedoutby == "")
                    {
                        img_Info.Visible = false;
                        if ((string)Session["CurrentlyViewedUserID"] == Session["UserID"].ToString())
                            imgB_Cancel.Visible = true;
                    }
                }
                catch 
                { 
                        img_Info.Visible = false;
                        if ((string)Session["CurrentlyViewedUserID"] == Session["UserID"].ToString())
                            imgB_Cancel.Visible = true;
                }    
            }
        }

        protected void GrdV_CraftingRequests_RowCommand(object sender, GridViewCommandEventArgs e)
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
                                cmd.Parameters.Add("@Request_ID", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[6].Text);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();

                            }
                        }
                        Session["OpenRequestsCollapse"] = "false"; //Tell the program not to collapse the panel on pageload
                        Response.Redirect(Request.RawUrl);
                        break;
                    #endregion
                }
            }
            catch { }
        }

        protected void GrdV_GatheringRequests_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int rewardID = (int)DataBinder.Eval(e.Row.DataItem, "RewardID");
                string rewardName = (string)DataBinder.Eval(e.Row.DataItem, "RewardName");
                Image img_Reward = (Image)e.Row.Cells[3].FindControl("img_Reward");
                Image img_Info = (Image)e.Row.Cells[5].FindControl("img_Info");
                ImageButton imgB_Cancel = (ImageButton)e.Row.Cells[7].FindControl("imgB_Cancel");
                imgB_Cancel.Visible = false;

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

                Image img_Flair = (Image)e.Row.Cells[5].FindControl("img_Flair");
                try
                {
                    int FulfilledCount = (int)DataBinder.Eval(e.Row.DataItem, "FulfilledCount");
                    if (FulfilledCount >= 3)
                    {
                        img_Flair.ImageUrl = "~/Resources/Flair/rsz_b_test1.png";
                        if (FulfilledCount >= 6)
                            img_Flair.ImageUrl = "~/Resources/Flair/rsz_s_test1.png";
                    }

                }
                catch { }

                try
                {
                    string checkedoutby = (string)DataBinder.Eval(e.Row.DataItem, "CheckedOutBy_Name");
                    if (checkedoutby == "")
                    {
                        img_Info.Visible = false;
                        if ((string)Session["CurrentlyViewedUserID"] == Session["UserID"].ToString())
                            imgB_Cancel.Visible = true;
                    }
                }
                catch
                {
                        img_Info.Visible = false;
                        if ((string)Session["CurrentlyViewedUserID"] == Session["UserID"].ToString())
                            imgB_Cancel.Visible = true;
                }
            }
        }

        protected void GrdV_GatheringRequests_RowCommand(object sender, GridViewCommandEventArgs e)
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
                            using (SqlCommand cmd = new SqlCommand("Cancel_GatheringRequest", con))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.Add("@Request_ID", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[6].Text);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();

                            }
                        }
                        Session["OpenRequestsCollapse"] = "false"; //Tell the program not to collapse the panel on pageload
                        Response.Redirect(Request.RawUrl);
                        break;
                    #endregion
                }
            }
            catch { }
        }

        protected void pnl_OpenRequestsBody_PreRender(object sender, EventArgs e)
        {
            if (this.GrdV_CraftingRequests.Height.Value >= this.GrdV_GatheringRequests.Height.Value)
                this.pnl_OpenRequestsBody_CollapsiblePanelExtender.ExpandedSize = (int)this.GrdV_CraftingRequests.Height.Value;
            else
                this.pnl_OpenRequestsBody_CollapsiblePanelExtender.ExpandedSize = (int)this.GrdV_GatheringRequests.Height.Value;
            this.pnl_OpenRequestsBody_CollapsiblePanelExtender.Collapsed = true; // By default, collapse the panel, BUT
            //If the user just deleted a record, don't collapse the panel
            try
            {
                if ((string)Session["OpenRequestsCollapse"] == "false")
                {
                    this.pnl_OpenRequestsBody_CollapsiblePanelExtender.Collapsed = false;
                    Session.Remove("OpenRequestsCollapse");
                }
            }
            catch { }
            //If the user is viewing another requester, do them the favor of telling them which one.
            try
            {
                if ((string)Session["CurrentlyViewedUser"] != Session["UserName"].ToString())
                {
                    this.pnl_OpenRequestsBody_CollapsiblePanelExtender.CollapsedText = Session["CurrentlyViewedUser"].ToString() + "\'s currently open requests";
                    this.pnl_OpenRequestsBody_CollapsiblePanelExtender.ExpandedText = Session["CurrentlyViewedUser"].ToString() + "\'s currently open requests";
                }
            }
            catch { }
        }
        #endregion
        #region OpenJobs

        protected void GrdV_CraftingJobs_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int rewardID = (int)DataBinder.Eval(e.Row.DataItem, "RewardID");
                string rewardName = (string)DataBinder.Eval(e.Row.DataItem, "RewardName");
                Image img_Reward = (Image)e.Row.Cells[4].FindControl("img_Reward");
                Image imgB_Drop = (Image)e.Row.Cells[7].FindControl("imgB_Drop");
                Image imgB_Fulfill = (Image)e.Row.Cells[7].FindControl("imgB_Fulfill");
                
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

                Image img_Flair = (Image)e.Row.Cells[0].FindControl("img_Flair");
                try
                {
                    int FulfilledCount = (int)DataBinder.Eval(e.Row.DataItem, "FulfilledCount");
                    if (FulfilledCount >= 3)
                    {
                        img_Flair.ImageUrl = "~/Resources/Flair/rsz_b_test1.png";
                        if (FulfilledCount >= 6)
                            img_Flair.ImageUrl = "~/Resources/Flair/rsz_s_test1.png";
                    }

                }
                catch { }

                if ((string)Session["CurrentlyViewedUserID"] != Session["UserID"].ToString())
                {
                    imgB_Drop.Visible = false;
                    imgB_Fulfill.Visible = false;
                }
            }
        }

        protected void GrdV_GatheringJobs_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int rewardID = (int)DataBinder.Eval(e.Row.DataItem, "RewardID");
                string rewardName = (string)DataBinder.Eval(e.Row.DataItem, "RewardName");
                Image img_Reward = (Image)e.Row.Cells[4].FindControl("img_Reward");
                Image imgB_Drop = (Image)e.Row.Cells[7].FindControl("imgB_Drop");
                Image imgB_Fulfill = (Image)e.Row.Cells[7].FindControl("imgB_Fulfill");

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

                Image img_Flair = (Image)e.Row.Cells[0].FindControl("img_Flair");
                try
                {
                    int FulfilledCount = (int)DataBinder.Eval(e.Row.DataItem, "FulfilledCount");
                    if (FulfilledCount >= 3)
                    {
                        img_Flair.ImageUrl = "~/Resources/Flair/rsz_b_test1.png";
                        if (FulfilledCount >= 6)
                            img_Flair.ImageUrl = "~/Resources/Flair/rsz_s_test1.png";
                    }

                }
                catch { }

                if ((string)Session["CurrentlyViewedUserID"] != Session["UserID"].ToString())
                {
                    imgB_Drop.Visible = false;
                    imgB_Fulfill.Visible = false;
                }
            }
        }

        protected void GrdV_CraftingJobs_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
                string commandName = e.CommandName.ToString();

                switch (commandName)
                {
                    //Fulfill a job
                    #region UpdateArgument
                    case "Update":
                        using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                        {
                            using (SqlCommand cmd = new SqlCommand("Check_slash_fulfill_Crafting", con))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.Add("@Check_User", SqlDbType.UniqueIdentifier).Value = new Guid(Session["UserID"].ToString());
                                cmd.Parameters.Add("@Request_ID", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[6].Text);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();

                            }
                        }
                        Session["OpenJobsCollapse"] = "false"; //Tell the program not to collapse the panel on pageload
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
                                cmd.Parameters.Add("@Request_ID", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[6].Text);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();

                            }
                        }
                        Session["OpenJobsCollapse"] = "false"; //Tell the program not to collapse the panel on pageload
                        Response.Redirect(Request.RawUrl);
                        break;
                    #endregion
                }
            }
            catch { }
        }
        
        protected void GrdV_GatheringJobs_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
                string commandName = e.CommandName.ToString();

                switch (commandName)
                {
                    //Fulfill a job
                    #region UpdateArgument
                    case "Update":
                        using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                        {
                            using (SqlCommand cmd = new SqlCommand("Check_slash_fulfill_Gathering", con))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.Add("@Check_User", SqlDbType.UniqueIdentifier).Value = new Guid(Session["UserID"].ToString());
                                cmd.Parameters.Add("@Request_ID", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[6].Text);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();

                            }
                        }
                        Session["OpenJobsCollapse"] = "false"; //Tell the program not to collapse the panel on pageload
                        Response.Redirect(Request.RawUrl);
                        break;
                    #endregion
                    // Drop a job
                    #region DeleteArgument
                    case "Delete":
                        using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["BlackjackTools_DB"].ToString()))
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE GatheringRequests_DB SET CheckedOutBy_User_ID = NULL, Date_CheckedOut = NULL WHERE (Request_ID = @Request_ID)", con))
                            {
                                cmd.CommandType = CommandType.Text;
                                cmd.Parameters.Add("@Request_ID", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[6].Text);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();

                            }
                        }
                        Session["OpenJobsCollapse"] = "false"; //Tell the program not to collapse the panel on pageload
                        Response.Redirect(Request.RawUrl);
                        break;
                    #endregion
                }
            }
            catch { }
        }

        protected void pnl_UserJobs_Body_PreRender(object sender, EventArgs e)
        {
            if (this.GrdV_CraftingJobs.Height.Value >= this.GrdV_GatheringJobs.Height.Value)
                this.pnl_UserJobs_Body_CollapsiblePanelExtender.ExpandedSize = (int)this.GrdV_CraftingJobs.Height.Value;
            else
                this.pnl_UserJobs_Body_CollapsiblePanelExtender.ExpandedSize = (int)this.GrdV_GatheringJobs.Height.Value;
            this.pnl_UserJobs_Body_CollapsiblePanelExtender.Collapsed = true; // By default, collapse the panel, BUT
            //If the user just dropped or fulfilled a record, don't collapse the panel
            try
            {
                if ((string)Session["OpenJobsCollapse"] == "false")
                {
                    this.pnl_UserJobs_Body_CollapsiblePanelExtender.Collapsed = false;
                    Session.Remove("OpenJobsCollapse");
                }
            }
            catch { }
            //If the user is viewing another requester, do them the favor of telling them which one.
            try
            {
                if ((string)Session["CurrentlyViewedUser"] != Session["UserName"].ToString())
                {
                    this.pnl_UserJobs_Body_CollapsiblePanelExtender.CollapsedText = Session["CurrentlyViewedUser"].ToString() + "\'s currently open jobs";
                    this.pnl_UserJobs_Body_CollapsiblePanelExtender.ExpandedText = Session["CurrentlyViewedUser"].ToString() + "\'s currently open jobs";
                }
            }
            catch { }
        }
        #endregion
        #region Fulfilled Jobs

        protected void GrdV_CraftingJobsIFulfilled_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int rewardID = (int)DataBinder.Eval(e.Row.DataItem, "RewardID");
                string rewardName = (string)DataBinder.Eval(e.Row.DataItem, "RewardName");
                Image img_Reward = (Image)e.Row.Cells[4].FindControl("img_Reward");

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
                Image img_Flair = (Image)e.Row.Cells[0].FindControl("img_Flair");
                try
                {
                    int FulfilledCount = (int)DataBinder.Eval(e.Row.DataItem, "FulfilledCount");
                    if (FulfilledCount >= 3)
                    {
                        img_Flair.ImageUrl = "~/Resources/Flair/rsz_b_test1.png";
                        if (FulfilledCount >= 6)
                            img_Flair.ImageUrl = "~/Resources/Flair/rsz_s_test1.png";
                    }

                }
                catch { }
            }
        }

        protected void GrdV_GatheringJobsIFulfilled_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int rewardID = (int)DataBinder.Eval(e.Row.DataItem, "RewardID");
                string rewardName = (string)DataBinder.Eval(e.Row.DataItem, "RewardName");
                Image img_Reward = (Image)e.Row.Cells[4].FindControl("img_Reward");

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
                Image img_Flair = (Image)e.Row.Cells[0].FindControl("img_Flair");
                try
                {
                    int FulfilledCount = (int)DataBinder.Eval(e.Row.DataItem, "FulfilledCount");
                    if (FulfilledCount >= 3)
                    {
                        img_Flair.ImageUrl = "~/Resources/Flair/rsz_b_test1.png";
                        if (FulfilledCount >= 6)
                            img_Flair.ImageUrl = "~/Resources/Flair/rsz_s_test1.png";
                    }

                }
                catch { }
            }
        }

        protected void pnl_JobsIFulfilled_Body_PreRender(object sender, EventArgs e)
        {
            if (this.GrdV_CraftingJobsIFulfilled.Height.Value >= this.GrdV_GatheringJobsIFulfilled.Height.Value)
                this.pnl_JobsIFulfilled_Body_CollapsiblePanelExtender.ExpandedSize = (int)this.GrdV_CraftingJobsIFulfilled.Height.Value;
            else
                this.pnl_JobsIFulfilled_Body_CollapsiblePanelExtender.ExpandedSize = (int)this.GrdV_GatheringJobsIFulfilled.Height.Value;
            try
            {
                if ((string)Session["CurrentlyViewedUser"] != Session["UserName"].ToString())
                {
                    this.pnl_JobsIFulfilled_Body_CollapsiblePanelExtender.CollapsedText = Session["CurrentlyViewedUser"].ToString() + "\'s fulfilled jobs";
                    this.pnl_JobsIFulfilled_Body_CollapsiblePanelExtender.ExpandedText = Session["CurrentlyViewedUser"].ToString() + "\'s fulfilled jobs";
                }
            }
            catch { }
        }
        #endregion
        #region Fulfilled Requests

        protected void GrdV_MyFulfilledCraftingJobs_RowCommand(object sender, GridViewCommandEventArgs e)
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
                                cmd.Parameters.Add("@Request_ID", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[8].Text);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();

                            }
                        }
                        Session["FulfilledRequestsCollapse"] = "false"; //Tell the program not to collapse the panel on pageload
                        Response.Redirect(Request.RawUrl);
                        break;
                }
            }
            catch { }
        }

        protected void GrdV_MyFulfilledCraftingJobs_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int rewardID = (int)DataBinder.Eval(e.Row.DataItem, "RewardID");
                string rewardName = (string)DataBinder.Eval(e.Row.DataItem, "RewardName");
                Image img_Reward = (Image)e.Row.Cells[3].FindControl("img_Reward");

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

                Image img_Flair = (Image)e.Row.Cells[5].FindControl("img_Flair");
                try
                {
                    int FulfilledCount = (int)DataBinder.Eval(e.Row.DataItem, "FulfilledCount");
                    if (FulfilledCount >= 3)
                    {
                        img_Flair.ImageUrl = "~/Resources/Flair/rsz_b_test1.png";
                        if (FulfilledCount >= 6)
                            img_Flair.ImageUrl = "~/Resources/Flair/rsz_s_test1.png";
                    }

                }
                catch { }

                bool verified = (bool)DataBinder.Eval(e.Row.DataItem, "Verified");
                ImageButton imgB_Verify = (ImageButton)e.Row.Cells[9].FindControl("imgB_Verify");
                imgB_Verify.Visible = false;

                if ((string)Session["CurrentlyViewedUserID"] == Session["UserID"].ToString())
                    if (verified == false) // If the job is not already verified
                        imgB_Verify.Visible = true; //Allow them to verify the job
            }
        }

        protected void GrdV_MyFulfilledGatheringJobs_RowCommand(object sender, GridViewCommandEventArgs e)
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
                            using (SqlCommand cmd = new SqlCommand("UPDATE GatheringRequests_DB SET Verified = 1, Date_Verified = GETDATE() WHERE (Request_ID = @Request_ID)", con))
                            {
                                cmd.CommandType = CommandType.Text;
                                cmd.Parameters.Add("@Request_ID", SqlDbType.BigInt).Value = Convert.ToInt32(row.Cells[8].Text);
                                con.Open();
                                cmd.ExecuteNonQuery();
                                cmd.Parameters.Clear();

                            }
                        }
                        Session["FulfilledRequestsCollapse"] = "false"; //Tell the program not to collapse the panel on pageload
                        Response.Redirect(Request.RawUrl);
                        break;
                }
            }
            catch { }
        }

        protected void GrdV_MyFulfilledGatheringJobs_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int rewardID = (int)DataBinder.Eval(e.Row.DataItem, "RewardID");
                string rewardName = (string)DataBinder.Eval(e.Row.DataItem, "RewardName");
                Image img_Reward = (Image)e.Row.Cells[3].FindControl("img_Reward");

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

                Image img_Flair = (Image)e.Row.Cells[5].FindControl("img_Flair");
                try
                {
                    int FulfilledCount = (int)DataBinder.Eval(e.Row.DataItem, "FulfilledCount");
                    if (FulfilledCount >= 3)
                    {
                        img_Flair.ImageUrl = "~/Resources/Flair/rsz_b_test1.png";
                        if (FulfilledCount >= 6)
                            img_Flair.ImageUrl = "~/Resources/Flair/rsz_s_test1.png";
                    }

                }
                catch { }

                bool verified = (bool)DataBinder.Eval(e.Row.DataItem, "Verified");
                ImageButton imgB_Verify = (ImageButton)e.Row.Cells[9].FindControl("imgB_Verify");
                imgB_Verify.Visible = false;

                if ((string)Session["CurrentlyViewedUserID"] == Session["UserID"].ToString())
                    if (verified == false) // If the job is not already verified
                        imgB_Verify.Visible = true; //Allow them to verify the job
            }
        }

        protected void pnl_MyFulfilledJobs_Body_PreRender(object sender, EventArgs e)
        {
            if (this.GrdV_MyFulfilledCraftingJobs.Height.Value >= this.GrdV_MyFulfilledGatheringJobs.Height.Value)
                this.pnl_MyFulfilledJobs_Body_CollapsiblePanelExtender.ExpandedSize = (int)this.GrdV_MyFulfilledCraftingJobs.Height.Value;
            else
                this.pnl_MyFulfilledJobs_Body_CollapsiblePanelExtender.ExpandedSize = (int)this.GrdV_MyFulfilledGatheringJobs.Height.Value;

            this.pnl_MyFulfilledJobs_Body_CollapsiblePanelExtender.Collapsed = true; // By default, collapse the panel, BUT
            //If the user just dropped or fulfilled a record, don't collapse the panel
            try
            {
                if ((string)Session["FulfilledRequestsCollapse"] == "false")
                {
                    this.pnl_MyFulfilledJobs_Body_CollapsiblePanelExtender.Collapsed = false;
                    Session.Remove("FulfilledRequestsCollapse");
                }
            }
            catch { }
            try
            {
                if ((string)Session["CurrentlyViewedUser"] != Session["UserName"].ToString())
                {
                    this.pnl_MyFulfilledJobs_Body_CollapsiblePanelExtender.CollapsedText = Session["CurrentlyViewedUser"].ToString() + "\'s fulfilled requests";
                    this.pnl_MyFulfilledJobs_Body_CollapsiblePanelExtender.ExpandedText = Session["CurrentlyViewedUser"].ToString() + "\'s fulfilled requests";
                }
            }
            catch { }
        }

        #endregion       
    }
}
