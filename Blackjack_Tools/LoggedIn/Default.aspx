<%@ Page Title="User Profile Page - Blackjack Tools" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Blackjack_Tools._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .style1
        {
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        <asp:Label ID="lbl_User" runat="server"></asp:Label>
        <asp:Label ID="Label20" runat="server" Text=" Profile"></asp:Label>
        <ajaxToolkit:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </ajaxToolkit:ToolkitScriptManager>
    </h2>
    <asp:UpdatePanel ID="Upnl_Users" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnl_OpenRequestsHeader" runat="server">
                <table>
                    <tr>
                        <td class="style1">
                            <asp:Image ID="img_Header" runat="server" ImageUrl="~/Resources/minus.gif" />
                            &nbsp;
                        </td>
                        <td class="style1">
                            <asp:Label ID="lbl_Header" runat="server" Font-Bold="True" Font-Size="Medium"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnl_OpenRequestsBody" runat="server" BorderStyle="Groove"
                onprerender="pnl_OpenRequestsBody_PreRender">
                <table width="100%">
                    <tr><td valign="top" width="50%">
                        <asp:Label ID="Label12" runat="server" Text="Crafting" Font-Bold="True"></asp:Label>
                            <asp:GridView ID="GrdV_CraftingRequests" runat="server" AutoGenerateColumns="False"
                                DataKeyNames="Request_ID" DataSourceID="SqlDataSource_USEROpenRequestsCrafting"
                                EnableModelValidation="True" AllowPaging="True" AllowSorting="True" 
                                onrowcommand="GrdV_CraftingRequests_RowCommand" 
                                onrowdatabound="GrdV_CraftingRequests_RowDataBound" Width="100%">
                                <Columns>
                                    <asp:HyperLinkField DataNavigateUrlFields="LinkURL" DataTextField="ItemName" 
                                        HeaderText="Item Name" SortExpression="ItemName" Target="_blank" />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" 
                                        SortExpression="Amount" DataFormatString="{0:#,###,##0}" >
                                    <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:CheckBoxField DataField="HQ" HeaderText="HQ" SortExpression="HQ" />
                                    <asp:TemplateField HeaderText="Reward" SortExpression="RewardAmount">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RewardAmount") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" 
                                                Text='<%# Bind("RewardAmount", "{0:#,###,##0}") %>' CssClass="currencyvalue"></asp:Label>
                                            <asp:Image ID="img_Reward" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Date_Requested" DataFormatString="{0:d}" HeaderText="Date Requested"
                                        SortExpression="Date_Requested" />
                                    <asp:TemplateField HeaderText="Checked Out By" 
                                        SortExpression="CheckedOutBy_Name">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" 
                                                Text='<%# Bind("CheckedOutBy_User_ID") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Image ID="img_Info" runat="server" ImageUrl="~/Resources/info_icon.png" 
                                                ImageAlign="Right" ToolTip='<%# Bind("Date_CheckedOut", "{0:d}") %>' />
                                            <asp:Image ID="img_Flair" runat="server" />
                                            <asp:HyperLink ID="hpl_CheckedOutBy" runat="server" 
                                                NavigateUrl='<%# Bind("CheckedOutBy_Name", "default.aspx?User={0}") %>' 
                                                Text='<%# Bind("CheckedOutBy_Name") %>'></asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Request_ID" SortExpression="Request_ID" 
                                        InsertVisible="False" ReadOnly="True" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgB_Cancel" runat="server" CausesValidation="False" 
                                                CommandName="Cancel" ImageUrl="~/Resources/Cancel__Red.png" 
                                                ToolTip="Cancel this Job" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    You don&#39;t currently have any outstanding crafting requests!
                                </EmptyDataTemplate>
                                <RowStyle Height="15px" />
                                <SelectedRowStyle BackColor="Black" />
                            </asp:GridView>
                            
                            <asp:SqlDataSource ID="SqlDataSource_USEROpenRequestsCrafting" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>" 
                                
                                
                                
                            
                            
                            
                            
                            SelectCommand="SELECT CraftingRequests_DB.Requester_ID, CraftingRequests_DB.Date_Requested, CraftingRequests_DB.CheckedOutBy_User_ID, CraftingRequests_DB.Date_CheckedOut, CraftingRequests_DB.Fulfilled, CraftingRequests_DB.Date_Fulfilled, CraftingRequests_DB.Request_ID, CraftingRequests_DB.HQ, CraftingRequests_DB.Verified, CraftingRequests_DB.Date_Verified, CraftingRequests_DB.Amount, Rewards.RewardName, CraftingRequests_DB.RewardAmount, CraftingRequests_DB.RewardID, aspnet_Users.UserName AS CheckedOutBy_Name, aspnet_Users.FulfilledCount, Items.ItemName, Items.LinkURL FROM CraftingRequests_DB INNER JOIN Rewards ON CraftingRequests_DB.RewardID = Rewards.RewardID INNER JOIN Items ON CraftingRequests_DB.CraftableItem_ID = Items.ItemID LEFT OUTER JOIN aspnet_Users ON CraftingRequests_DB.CheckedOutBy_User_ID = aspnet_Users.UserId WHERE (CraftingRequests_DB.Requester_ID = @Requester_ID) AND (CraftingRequests_DB.Fulfilled = 0)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="Requester_ID" SessionField="CurrentlyViewedUserID" 
                                        Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            
                        </td>
                        
                        <td valign="top">
                            <asp:Label ID="Label13" runat="server" Text="Gathering" Font-Bold="True"></asp:Label>
                            <asp:GridView ID="GrdV_GatheringRequests" runat="server" AutoGenerateColumns="False"
                                DataKeyNames="Request_ID" DataSourceID="SqlDataSource_USEROpenRequestsGathering"
                                EnableModelValidation="True" Style="margin-right: 3px" AllowPaging="True" 
                                AllowSorting="True" onrowcommand="GrdV_GatheringRequests_RowCommand" 
                                onrowdatabound="GrdV_GatheringRequests_RowDataBound" Width="100%">
                                <Columns>
                                    <asp:HyperLinkField DataNavigateUrlFields="LinkURL" DataTextField="ItemName" 
                                        HeaderText="Item Name" SortExpression="Item Name" Target="_blank" />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" 
                                        DataFormatString="{0:#,###,##0}" >
                                    <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:CheckBoxField DataField="HQ" HeaderText="HQ" SortExpression="HQ" />
                                    <asp:TemplateField HeaderText="Reward" SortExpression="RewardAmount">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RewardAmount") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" 
                                                Text='<%# Bind("RewardAmount", "{0:#,###,##0}") %>' CssClass="currencyvalue"></asp:Label>
                                            <asp:Image ID="img_Reward" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Date_Requested" DataFormatString="{0:d}" HeaderText="Date Requested"
                                        SortExpression="Date_Requested" />
                                    <asp:TemplateField HeaderText="Checked Out By" 
                                        SortExpression="CheckedOutBy_Name">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" 
                                                Text='<%# Bind("CheckedOutBy_User_ID") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Image ID="img_Flair" runat="server" />
                                            <asp:HyperLink ID="hpl_CheckedOutBy" runat="server" 
                                                NavigateUrl='<%# Bind("CheckedOutBy_Name", "default.aspx?User={0}") %>' 
                                                Text='<%# Bind("CheckedOutBy_Name") %>'></asp:HyperLink>
                                            <asp:Image ID="img_Info" runat="server" ImageUrl="~/Resources/info_icon.png" 
                                                ImageAlign="Right" ToolTip='<%# Bind("Date_CheckedOut", "{0:d}") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Request_ID" SortExpression="Request_ID" 
                                        InsertVisible="False" ReadOnly="True" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgB_Cancel" runat="server" CausesValidation="False" 
                                                CommandName="Cancel" ImageUrl="~/Resources/Cancel__Red.png" 
                                                ToolTip="Cancel this Job" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    You don&#39;t currently have any outstanding gathering requests!<br />
                                    <br />
                                    Is that a good thing?
                                </EmptyDataTemplate>
                                <RowStyle Height="15px" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource_USEROpenRequestsGathering" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>" 
                                
                                
                                
                                
                                
                                
                                
                                SelectCommand="SELECT GatheringRequests_DB.Requester_ID, GatheringRequests_DB.Amount, GatheringRequests_DB.Date_Requested, GatheringRequests_DB.CheckedOutBy_User_ID, GatheringRequests_DB.Date_CheckedOut, GatheringRequests_DB.Fulfilled, GatheringRequests_DB.Date_Fulfilled, GatheringRequests_DB.Request_ID, GatheringRequests_DB.HQ, GatheringRequests_DB.Verified, GatheringRequests_DB.Date_Verified, Rewards.RewardName, GatheringRequests_DB.RewardAmount, GatheringRequests_DB.RewardID, aspnet_Users.UserName AS CheckedOutBy_Name, aspnet_Users.FulfilledCount, Items.ItemName, Items.LinkURL FROM GatheringRequests_DB INNER JOIN Rewards ON GatheringRequests_DB.RewardID = Rewards.RewardID INNER JOIN Items ON GatheringRequests_DB.GatherableItem_ID = Items.ItemID LEFT OUTER JOIN aspnet_Users ON GatheringRequests_DB.CheckedOutBy_User_ID = aspnet_Users.UserId WHERE (GatheringRequests_DB.Requester_ID = @Requester_ID) AND (GatheringRequests_DB.Fulfilled = 0)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="Requester_ID" SessionField="CurrentlyViewedUserID" 
                                        Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="pnl_OpenRequestsBody_CollapsiblePanelExtender"
                runat="server" CollapseControlID="pnl_OpenRequestsHeader" CollapsedText="Your Open Requests"
                Enabled="True" TextLabelID="lbl_Header" ExpandControlID="pnl_OpenRequestsHeader"
                ExpandedSize="350" ExpandedText="Your Open Requests" TargetControlID="pnl_OpenRequestsBody"
                CollapsedSize="0" CollapsedImage="~/Resources/plus.gif" ExpandedImage="~/Resources/minus.gif"
                ImageControlID="img_Header" Collapsed="True">
            </ajaxToolkit:CollapsiblePanelExtender>
            <asp:Panel ID="pnl_UserOpenJobs_Header" runat="server">
                <table>
                    <tr>
                        <td class="style1">
                            <asp:Image ID="img_Jobs_Header" runat="server" ImageUrl="~/Resources/minus.gif" />&nbsp;
                        </td>
                        <td class="style1">
                            <asp:Label ID="lbl_Jobs_Header" runat="server" Font-Bold="True" Font-Size="Medium"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnl_UserJobs_Body" runat="server" BorderStyle="Groove" 
                onprerender="pnl_UserJobs_Body_PreRender">
                <table width="100%">
                    <tr>
                        <td valign="top" width="50%">
                            <asp:Label ID="Label14" runat="server" Font-Bold="True" Text="Crafting"></asp:Label>
                            <asp:GridView ID="GrdV_CraftingJobs" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" DataKeyNames="Request_ID" DataSourceID="SqlDataSource_CraftingJobs"
                                EnableModelValidation="True" onrowcommand="GrdV_CraftingJobs_RowCommand" 
                                onrowdatabound="GrdV_CraftingJobs_RowDataBound" Width="100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="Requester" SortExpression="Requester_Name">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Requester_ID") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Image ID="img_Flair" runat="server" />
                                            <asp:HyperLink ID="hpl_Requester" runat="server" 
                                                NavigateUrl='<%# Bind("Requester_Name", "default.aspx?User={0}") %>' 
                                                Text='<%# Bind("Requester_Name") %>'></asp:HyperLink>
                                                <asp:Image ID="Image3" runat="server" ImageUrl="~/Resources/info_icon.png" 
                                                ImageAlign="Right" ToolTip='<%# Bind("Date_Requested", "{0:d}") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:HyperLinkField DataNavigateUrlFields="LinkURL" DataTextField="ItemName" 
                                        HeaderText="Item Name" Target="_blank" SortExpression="ItemName" />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" 
                                        SortExpression="Amount" DataFormatString="{0:#,###,##0}" >
                                    <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:CheckBoxField DataField="HQ" HeaderText="HQ" SortExpression="HQ" />
                                    <asp:TemplateField HeaderText="Reward" SortExpression="RewardAmount">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RewardAmount") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" 
                                                Text='<%# Bind("RewardAmount", "{0:#,###,##0}") %>' CssClass="currencyvalue"></asp:Label>
                                            <asp:Image ID="img_Reward" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Date_CheckedOut" DataFormatString="{0:d}" HeaderText="Date Checked Out"
                                        SortExpression="Date_CheckedOut" />
                                    <asp:BoundField DataField="Request_ID" InsertVisible="False" ReadOnly="True" SortExpression="Request_ID" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgB_Drop" runat="server" CausesValidation="False" 
                                                CommandName="Delete" ImageUrl="~/Resources/red-x-icon.png" 
                                                ToolTip="Drop this Job" />
                                            <asp:ImageButton ID="imgB_Fulfill" runat="server" CausesValidation="False" 
                                                CommandName="Update" ImageUrl="~/Resources/icon_ArrowNext.png" 
                                                ToolTip="Mark this job as fulfilled and ready for pickup" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    You do not have any currently outstanding crafting jobs!
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource_CraftingJobs" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                                
                                
                                
                                
                                
                                
                                SelectCommand="SELECT CraftingRequests_DB.Requester_ID, CraftingRequests_DB.Date_Requested, CraftingRequests_DB.CheckedOutBy_User_ID, CraftingRequests_DB.Date_CheckedOut, CraftingRequests_DB.Fulfilled, CraftingRequests_DB.Date_Fulfilled, CraftingRequests_DB.Request_ID, CraftingRequests_DB.HQ, CraftingRequests_DB.Verified, CraftingRequests_DB.Date_Verified, CraftingRequests_DB.Amount, Rewards.RewardName, CraftingRequests_DB.RewardAmount, CraftingRequests_DB.RewardID, aspnet_Users.UserName AS Requester_Name, aspnet_Users.FulfilledCount, Items.ItemName, Items.LinkURL FROM CraftingRequests_DB INNER JOIN Rewards ON CraftingRequests_DB.RewardID = Rewards.RewardID INNER JOIN aspnet_Users ON CraftingRequests_DB.Requester_ID = aspnet_Users.UserId INNER JOIN Items ON CraftingRequests_DB.CraftableItem_ID = Items.ItemID WHERE (CraftingRequests_DB.CheckedOutBy_User_ID = @CheckedOutBy_User_ID) AND (CraftingRequests_DB.Fulfilled = 0)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="CheckedOutBy_User_ID" 
                                        SessionField="CurrentlyViewedUserID" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td valign="top">
                            <asp:Label ID="Label15" runat="server" Font-Bold="True" Text="Gathering"></asp:Label>
                            <asp:GridView ID="GrdV_GatheringJobs" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" DataKeyNames="Request_ID" DataSourceID="SqlDataSource_GatheringJobs"
                                EnableModelValidation="True" onrowcommand="GrdV_GatheringJobs_RowCommand" 
                                onrowdatabound="GrdV_GatheringJobs_RowDataBound" Width="100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="Requester" SortExpression="Requester_Name">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Requester_ID") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Image ID="img_Flair" runat="server" />
                                            <asp:HyperLink ID="hpl_Requester" runat="server" 
                                                NavigateUrl='<%# Bind("Requester_Name", "default.aspx?User={0}") %>' 
                                                Text='<%# Bind("Requester_Name") %>'></asp:HyperLink>
                                                <asp:Image ID="Image4" runat="server" ImageUrl="~/Resources/info_icon.png" 
                                                ImageAlign="Right" ToolTip='<%# Bind("Date_Requested", "{0:d}") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:HyperLinkField DataNavigateUrlFields="LinkURL" DataTextField="ItemName" 
                                        HeaderText="Item Name" SortExpression="ItemName" Target="_blank" />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" 
                                        DataFormatString="{0:#,###,##0}" >
                                    <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:CheckBoxField DataField="HQ" HeaderText="HQ" SortExpression="HQ" />
                                    <asp:TemplateField HeaderText="Reward" SortExpression="RewardAmount">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RewardAmount") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" 
                                                Text='<%# Bind("RewardAmount", "{0:#,###,##0}") %>' CssClass="currencyvalue"></asp:Label>
                                            <asp:Image ID="img_Reward" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Date_CheckedOut" DataFormatString="{0:d}" HeaderText="Date Checked Out"
                                        SortExpression="Date_CheckedOut" />
                                    <asp:BoundField DataField="Request_ID" InsertVisible="False" ReadOnly="True" SortExpression="Request_ID" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgB_Drop" runat="server" CausesValidation="False" 
                                                CommandName="Delete" ImageUrl="~/Resources/red-x-icon.png" 
                                                ToolTip="Drop this Job" />
                                            <asp:ImageButton ID="imgB_Fulfill" runat="server" CausesValidation="False" 
                                                CommandName="Update" ImageUrl="~/Resources/icon_ArrowNext.png" 
                                                ToolTip="Mark this job as fulfilled and ready for pickup" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    You do not currently have any outstanding gathering jobs!<br />
                                    <br />
                                    Get one today! You can do it!
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource_GatheringJobs" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                                
                                
                                
                                
                                
                                
                                SelectCommand="SELECT GatheringRequests_DB.Requester_ID, GatheringRequests_DB.Amount, GatheringRequests_DB.Date_Requested, GatheringRequests_DB.CheckedOutBy_User_ID, GatheringRequests_DB.Date_CheckedOut, GatheringRequests_DB.Fulfilled, GatheringRequests_DB.Date_Fulfilled, GatheringRequests_DB.Request_ID, GatheringRequests_DB.HQ, GatheringRequests_DB.Verified, GatheringRequests_DB.Date_Verified, GatheringRequests_DB.RewardAmount, GatheringRequests_DB.RewardID, Rewards.RewardName, aspnet_Users.UserName AS Requester_Name, aspnet_Users.FulfilledCount, Items.ItemName, Items.LinkURL FROM GatheringRequests_DB INNER JOIN Rewards ON GatheringRequests_DB.RewardID = Rewards.RewardID INNER JOIN aspnet_Users ON GatheringRequests_DB.Requester_ID = aspnet_Users.UserId INNER JOIN Items ON GatheringRequests_DB.GatherableItem_ID = Items.ItemID WHERE (GatheringRequests_DB.CheckedOutBy_User_ID = @CheckedOutBy_User_ID) AND (GatheringRequests_DB.Fulfilled = 0)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="CheckedOutBy_User_ID" 
                                        SessionField="CurrentlyViewedUserID" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="pnl_UserJobs_Body_CollapsiblePanelExtender"
                runat="server" CollapseControlID="pnl_UserOpenJobs_Header" CollapsedImage="~/Resources/plus.gif"
                CollapsedSize="0" CollapsedText="Your Jobs in Progress" Enabled="True" ExpandControlID="pnl_UserOpenJobs_Header"
                ExpandedImage="~/Resources/minus.gif" ExpandedSize="350" ExpandedText="Your Jobs in Progress"
                ImageControlID="img_Jobs_Header" TargetControlID="pnl_UserJobs_Body" TextLabelID="lbl_Jobs_Header"
                Collapsed="True">
            </ajaxToolkit:CollapsiblePanelExtender>
            <asp:Panel ID="pnl_JobsIFulfilled_Header" runat="server">
                <table>
                    <tr>
                        <td>
                            <asp:Image ID="img_JobsIFulfilled_Header" runat="server" ImageUrl="~/Resources/plus.gif" />&nbsp;
                        </td>
                        <td>
                            <asp:Label ID="lbl_JobsIFulfilled_Header" runat="server" Font-Bold="True" Font-Size="Medium"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnl_JobsIFulfilled_Body" runat="server" BorderStyle="Groove" 
                onprerender="pnl_JobsIFulfilled_Body_PreRender">
                <table width="100%">
                    <tr>
                        <td valign="top" width="50%">
                            <asp:Label ID="Label16" runat="server" Font-Bold="True" Text="Crafting"></asp:Label>
                            <asp:GridView ID="GrdV_CraftingJobsIFulfilled" runat="server" AllowPaging="True"
                                AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Request_ID" DataSourceID="SqlDataSource_CraftingJobsIFulfilled"
                                EnableModelValidation="True" 
                                onrowdatabound="GrdV_CraftingJobsIFulfilled_RowDataBound" Width="100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="Requester" SortExpression="Requester_Name">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Requester_ID") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Image ID="img_Flair" runat="server" />
                                            <asp:HyperLink ID="hpl_Requester" runat="server" 
                                                NavigateUrl='<%# Bind("Requester_Name", "default.aspx?User={0}") %>' 
                                                Text='<%# Bind("Requester_Name") %>'></asp:HyperLink>
                                                <asp:Image ID="Image5" runat="server" ImageUrl="~/Resources/info_icon.png" 
                                                ImageAlign="Right" ToolTip='<%# Bind("Date_Requested", "{0:d}") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:HyperLinkField DataNavigateUrlFields="LinkURL" DataTextField="ItemName" 
                                        HeaderText="Item Name" SortExpression="ItemName" Target="_blank" />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" 
                                        SortExpression="Amount" DataFormatString="{0:#,###,##0}" >
                                    <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:CheckBoxField DataField="HQ" HeaderText="HQ" SortExpression="HQ" />
                                    <asp:TemplateField HeaderText="Reward" SortExpression="RewardAmount">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RewardAmount") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Right"/>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" 
                                                Text='<%# Bind("RewardAmount", "{0:#,###,##0}") %>' CssClass="currencyvalue"></asp:Label>
                                            <asp:Image ID="img_Reward" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Date_CheckedOut" DataFormatString="{0:d}" HeaderText="Date Checked Out"
                                        SortExpression="Date_CheckedOut" />
                                    <asp:BoundField DataField="Date_Fulfilled" DataFormatString="{0:d}" HeaderText="Date Fulfilled"
                                        SortExpression="Date_Fulfilled" />
                                    <asp:TemplateField HeaderText="Verified" SortExpression="Verified">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Verified") %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Verified") %>' 
                                                Enabled="false" />
                                            <asp:Image ID="img_Verified" runat="server" ImageAlign="Right" 
                                                ImageUrl="~/Resources/info_icon.png" 
                                                ToolTip='<%# Bind("Date_Verified", "{0:d}") %>' 
                                                Visible='<%# Bind("Verified") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    You have not yet fulfilled any requests!<br />
                                    <br />
                                    Become a fairy godmother today and make wishes come true!
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource_CraftingJobsIFulfilled" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                                
                                
                                
                                
                                
                                
                                SelectCommand="SELECT CraftingRequests_DB.Requester_ID, CraftingRequests_DB.Date_Requested, CraftingRequests_DB.CheckedOutBy_User_ID, CraftingRequests_DB.Date_CheckedOut, CraftingRequests_DB.Fulfilled, CraftingRequests_DB.Date_Fulfilled, CraftingRequests_DB.Request_ID, CraftingRequests_DB.HQ, CraftingRequests_DB.Verified, CraftingRequests_DB.Date_Verified, CraftingRequests_DB.Amount, Rewards.RewardName, CraftingRequests_DB.RewardAmount, CraftingRequests_DB.RewardID, aspnet_Users.UserName AS Requester_Name, aspnet_Users.FulfilledCount, Items.ItemName, Items.LinkURL, Items.ItemID FROM CraftingRequests_DB INNER JOIN Rewards ON CraftingRequests_DB.RewardID = Rewards.RewardID INNER JOIN aspnet_Users ON CraftingRequests_DB.Requester_ID = aspnet_Users.UserId INNER JOIN Items ON CraftingRequests_DB.CraftableItem_ID = Items.ItemID WHERE (CraftingRequests_DB.CheckedOutBy_User_ID = @CheckedOutBy) AND (CraftingRequests_DB.Fulfilled = 1) ORDER BY CraftingRequests_DB.Date_Fulfilled DESC">
                                <SelectParameters>
                                    <asp:SessionParameter Name="CheckedOutBy" 
                                        SessionField="CurrentlyViewedUserID" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td valign="top">
                            <asp:Label ID="Label17" runat="server" Font-Bold="True" Text="Gathering"></asp:Label>
                            <asp:GridView ID="GrdV_GatheringJobsIFulfilled" runat="server" AllowPaging="True"
                                AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Request_ID" DataSourceID="SqlDataSource_GatheringJobsIFulfilled"
                                EnableModelValidation="True" 
                                onrowdatabound="GrdV_GatheringJobsIFulfilled_RowDataBound" Width="100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="Requester" SortExpression="Requester_Name">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Requester_ID") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Image ID="img_Flair" runat="server" />
                                            <asp:HyperLink ID="hpl_Requester" runat="server" 
                                                NavigateUrl='<%# Bind("Requester_Name", "default.aspx?User={0}") %>' 
                                                Text='<%# Bind("Requester_Name") %>'></asp:HyperLink>
                                                 <asp:Image ID="Image6" runat="server" ImageUrl="~/Resources/info_icon.png" 
                                                ImageAlign="Right" ToolTip='<%# Bind("Date_Requested", "{0:d}") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:HyperLinkField DataNavigateUrlFields="LinkURL" DataTextField="ItemName" 
                                        HeaderText="Item Name" SortExpression="ItemName" Target="_blank" />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" 
                                        DataFormatString="{0:#,###,##0}" >
                                    <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:CheckBoxField DataField="HQ" HeaderText="HQ" SortExpression="HQ" />
                                    <asp:TemplateField HeaderText="Reward" SortExpression="RewardAmount">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RewardAmount") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" CssClass="currencyvalue" 
                                                Text='<%# Bind("RewardAmount", "{0:#,###,##0}") %>'></asp:Label>
                                            <asp:Image ID="img_Reward" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Date_CheckedOut" DataFormatString="{0:d}" HeaderText="Date Checked Out"
                                        SortExpression="Date_CheckedOut" />
                                    <asp:BoundField DataField="Date_Fulfilled" DataFormatString="{0:d}" HeaderText="Date Fulfilled"
                                        SortExpression="Date_Fulfilled" />
                                    <asp:TemplateField HeaderText="Verified" SortExpression="Verified">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Verified") %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Verified") %>' 
                                                Enabled="false" />
                                            <asp:Image ID="img_Verified" runat="server" ImageAlign="Right" 
                                                ImageUrl="~/Resources/info_icon.png" 
                                                ToolTip='<%# Bind("Date_Verified", "{0:d}") %>' 
                                                Visible='<%# Bind("Verified") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    You have not yet fulfilled any gathering requests!
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource_GatheringJobsIFulfilled" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                                
                                
                                
                                
                                
                                
                                SelectCommand="SELECT GatheringRequests_DB.Requester_ID, GatheringRequests_DB.Amount, GatheringRequests_DB.Date_Requested, GatheringRequests_DB.CheckedOutBy_User_ID, GatheringRequests_DB.Date_CheckedOut, GatheringRequests_DB.Fulfilled, GatheringRequests_DB.Date_Fulfilled, GatheringRequests_DB.Request_ID, GatheringRequests_DB.HQ, GatheringRequests_DB.Verified, GatheringRequests_DB.Date_Verified, Rewards.RewardName, GatheringRequests_DB.RewardAmount, GatheringRequests_DB.RewardID, aspnet_Users.UserName AS Requester_Name, aspnet_Users.FulfilledCount, Items.ItemName, Items.LinkURL FROM GatheringRequests_DB INNER JOIN Rewards ON GatheringRequests_DB.RewardID = Rewards.RewardID INNER JOIN aspnet_Users ON GatheringRequests_DB.Requester_ID = aspnet_Users.UserId INNER JOIN Items ON GatheringRequests_DB.GatherableItem_ID = Items.ItemID WHERE (GatheringRequests_DB.Fulfilled = 1) AND (GatheringRequests_DB.CheckedOutBy_User_ID = @CheckedOutBy) ORDER BY GatheringRequests_DB.Date_Fulfilled DESC">
                                <SelectParameters>
                                    <asp:SessionParameter Name="CheckedOutBy" 
                                        SessionField="CurrentlyViewedUserID" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="pnl_JobsIFulfilled_Body_CollapsiblePanelExtender"
                runat="server" CollapseControlID="pnl_JobsIFulfilled_Header" Collapsed="True"
                CollapsedImage="~/Resources/plus.gif" CollapsedSize="0" CollapsedText="Jobs You've Fulfilled"
                Enabled="True" ExpandControlID="pnl_JobsIFulfilled_Header" ExpandedImage="~/Resources/minus.gif"
                ExpandedSize="350" ExpandedText="Jobs You've Fulfilled" ImageControlID="img_JobsIFulfilled_Header"
                TargetControlID="pnl_JobsIFulfilled_Body" TextLabelID="lbl_JobsIFulfilled_Header">
            </ajaxToolkit:CollapsiblePanelExtender>
            <asp:Panel ID="pnl_MyFulfilledJobs_Header" runat="server">
                <table>
                    <tr>
                        <td>
                            <asp:Image ID="img_MyFulfilledJobs_Header" runat="server" ImageUrl="~/Resources/plus.gif" />&nbsp;
                        </td>
                        <td>
                            <asp:Label ID="lbl_MyFulfilledJobs_Header" runat="server" Font-Bold="True" Font-Size="Medium"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnl_MyFulfilledJobs_Body" runat="server" BorderStyle="Groove" 
                onprerender="pnl_MyFulfilledJobs_Body_PreRender">
                <table width="100%">
                    <tr>
                        <td valign="top" width="50%">
                            <asp:Label ID="Label19" runat="server" Font-Bold="True" Text="Crafting"></asp:Label>
                            <asp:GridView ID="GrdV_MyFulfilledCraftingJobs" runat="server" AllowPaging="True"
                                AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Request_ID" DataSourceID="SqlDataSource_MyFulfilledCraftingJobs"
                                EnableModelValidation="True" 
                                onrowcommand="GrdV_MyFulfilledCraftingJobs_RowCommand" 
                                onrowdatabound="GrdV_MyFulfilledCraftingJobs_RowDataBound" Width="100%">
                                <Columns>
                                    <asp:HyperLinkField DataNavigateUrlFields="LinkURL" DataTextField="ItemName" 
                                        HeaderText="Item Name" SortExpression="ItemName" Target="_blank" />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" 
                                        SortExpression="Amount" DataFormatString="{0:#,###,##0}" >
                                    <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:CheckBoxField DataField="HQ" HeaderText="HQ" SortExpression="HQ" />
                                    <asp:TemplateField HeaderText="Reward" SortExpression="RewardAmount">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("RewardAmount") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle  HorizontalAlign="Right"/>
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" 
                                                Text='<%# Bind("RewardAmount", "{0:#,###,##0}") %>' CssClass="currencyvalue"></asp:Label>
                                            <asp:Image ID="img_Reward" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Date_Requested" DataFormatString="{0:d}" HeaderText="Date Requested"
                                        SortExpression="Date_Requested" />
                                    <asp:TemplateField HeaderText="Checked Out By" 
                                        SortExpression="CheckedOutBy_Name">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" 
                                                Text='<%# Bind("CheckedOutBy_User_ID") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Image ID="Image7" runat="server" ImageAlign="Right" 
                                                ImageUrl="~/Resources/info_icon.png" 
                                                ToolTip='<%# Bind("Date_CheckedOut", "{0:d}") %>' />
                                            <asp:Image ID="img_Flair" runat="server" />
                                            <asp:HyperLink ID="hpl_CheckedOutBy" runat="server" 
                                                NavigateUrl='<%# Bind("CheckedOutBy_Name", "default.aspx?User={0}") %>' 
                                                Text='<%# Bind("CheckedOutBy_Name") %>'></asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fulfilled" 
                                        SortExpression="Date_Fulfilled">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" 
                                                Text='<%# Bind("FulfilledBy_User_ID") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chk_Fulfilled" runat="server" 
                                                Checked='<%# Bind("Fulfilled") %>' Enabled="False" />
                                            <asp:Image ID="Image8" runat="server" ImageAlign="Right" 
                                                ImageUrl="~/Resources/info_icon.png" 
                                                ToolTip='<%# Bind("Date_CheckedOut", "{0:d}") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Verified" SortExpression="Verified">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Verified") %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Verified") %>' 
                                                Enabled="false" />
                                            <asp:Image ID="Image11" runat="server" ImageAlign="Right" 
                                                ImageUrl="~/Resources/info_icon.png" 
                                                ToolTip='<%# Bind("Date_Verified", "{0:d}") %>' 
                                                Visible='<%# Bind("Verified") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Request_ID" SortExpression="Request_ID" />
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgB_Verify" runat="server" CausesValidation="False" 
                                                CommandName="Update" ImageUrl="~/Resources/green-checkmark.png" 
                                                ToolTip="Verify receipt of goods" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    My deepest apologies, it appears none of your requests have been fulfilled yet,
                                    Master Bruce.
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource_MyFulfilledCraftingJobs" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                                
                                
                                
                                
                                
                                
                                SelectCommand="SELECT CraftingRequests_DB.Requester_ID, CraftingRequests_DB.Date_Requested, CraftingRequests_DB.CheckedOutBy_User_ID, CraftingRequests_DB.Date_CheckedOut, CraftingRequests_DB.Fulfilled, CraftingRequests_DB.Date_Fulfilled, CraftingRequests_DB.Request_ID, CraftingRequests_DB.HQ, CraftingRequests_DB.Verified, CraftingRequests_DB.Date_Verified, CraftingRequests_DB.Amount, Rewards.RewardName, CraftingRequests_DB.RewardAmount, CraftingRequests_DB.RewardID, aspnet_Users.UserName AS CheckedOutBy_Name, aspnet_Users.FulfilledCount, Items.ItemName, Items.LinkURL FROM CraftingRequests_DB INNER JOIN Rewards ON CraftingRequests_DB.RewardID = Rewards.RewardID INNER JOIN aspnet_Users ON CraftingRequests_DB.CheckedOutBy_User_ID = aspnet_Users.UserId INNER JOIN Items ON CraftingRequests_DB.CraftableItem_ID = Items.ItemID WHERE (CraftingRequests_DB.Requester_ID = @Requester_ID) AND (CraftingRequests_DB.Fulfilled = 1) ORDER BY CraftingRequests_DB.Date_Fulfilled DESC">
                                <SelectParameters>
                                    <asp:SessionParameter Name="Requester_ID" SessionField="CurrentlyViewedUserID" 
                                        Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td valign="top">
                            <asp:Label ID="Label18" runat="server" Font-Bold="True" Text="Gathering"></asp:Label>
                            <asp:GridView ID="GrdV_MyFulfilledGatheringJobs" runat="server" AllowPaging="True"
                                AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Request_ID" DataSourceID="SqlDataSource_MyFulfilledGatheringJobs"
                                EnableModelValidation="True" 
                                onrowcommand="GrdV_MyFulfilledGatheringJobs_RowCommand" 
                                onrowdatabound="GrdV_MyFulfilledGatheringJobs_RowDataBound" Width="100%">
                                <Columns>
                                    <asp:HyperLinkField DataNavigateUrlFields="LinkURL" DataTextField="ItemName" 
                                        HeaderText="Item Name" SortExpression="ItemName" Target="_blank" />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" 
                                        DataFormatString="{0:#,###,##0}" >
                                    <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:CheckBoxField DataField="HQ" HeaderText="HQ" SortExpression="HQ" />
                                    <asp:TemplateField HeaderText="Reward" SortExpression="RewardAmount">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("RewardAmount") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" CssClass="currencyvalue" 
                                                Text='<%# Bind("RewardAmount", "{0:#,###,##0}") %>'></asp:Label>
                                            <asp:Image ID="img_Reward" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Date_Requested" DataFormatString="{0:d}" HeaderText="Date Requested"
                                        SortExpression="Date_Requested" />
                                    <asp:TemplateField HeaderText="Checked Out By" 
                                        SortExpression="CheckedOutBy_Name">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" 
                                                Text='<%# Bind("CheckedOutBy_User_ID") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Image ID="Image9" runat="server" ImageUrl="~/Resources/info_icon.png" 
                                                ImageAlign="Right" ToolTip='<%# Bind("Date_CheckedOut", "{0:d}") %>' />
                                            <asp:Image ID="img_Flair" runat="server" />
                                            <asp:HyperLink ID="hpl_CheckedOutBy" runat="server" 
                                                NavigateUrl='<%# Bind("CheckedOutBy_Name", "default.aspx?User={0}") %>' 
                                                Text='<%# Bind("CheckedOutBy_Name") %>'></asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fulfilled" 
                                        SortExpression="Date_Fulfilled">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" 
                                                Text='<%# Bind("FulfilledBy_User_ID") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chk_Fulfilled" runat="server" 
                                                Checked='<%# Bind("Fulfilled") %>' Enabled="False" />
                                            <asp:Image ID="Image10" runat="server" ImageUrl="~/Resources/info_icon.png" 
                                                ImageAlign="Right" ToolTip='<%# Bind("Date_Fulfilled", "{0:d}") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Verified" SortExpression="Verified">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Verified") %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Verified") %>' 
                                                Enabled="false" />
                                            <asp:Image ID="img_Verified" runat="server" ImageAlign="Right" 
                                                ImageUrl="~/Resources/info_icon.png" 
                                                ToolTip='<%# Bind("Date_Verified", "{0:d}") %>' 
                                                Visible='<%# Bind("Verified") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Request_ID" SortExpression="Request_ID" />
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgB_Verify" runat="server" CausesValidation="False" 
                                                CommandName="Update" ImageUrl="~/Resources/green-checkmark.png" 
                                                ToolTip="Verify receipt of goods" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    None of your gathering requests have been fulfilled yet.<br />
                                    <br />
                                    So sorry.
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource_MyFulfilledGatheringJobs" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                                
                                
                                
                                
                                
                                
                                SelectCommand="SELECT GatheringRequests_DB.Requester_ID, GatheringRequests_DB.Amount, GatheringRequests_DB.Date_Requested, GatheringRequests_DB.CheckedOutBy_User_ID, GatheringRequests_DB.Date_CheckedOut, GatheringRequests_DB.Fulfilled, GatheringRequests_DB.Date_Fulfilled, GatheringRequests_DB.Request_ID, GatheringRequests_DB.HQ, GatheringRequests_DB.Verified, GatheringRequests_DB.Date_Verified, Rewards.RewardName, GatheringRequests_DB.RewardAmount, GatheringRequests_DB.RewardID, aspnet_Users.UserName AS CheckedOutBy_Name, aspnet_Users.FulfilledCount, Items.ItemName, Items.LinkURL FROM GatheringRequests_DB INNER JOIN Rewards ON GatheringRequests_DB.RewardID = Rewards.RewardID INNER JOIN aspnet_Users ON GatheringRequests_DB.CheckedOutBy_User_ID = aspnet_Users.UserId INNER JOIN Items ON GatheringRequests_DB.GatherableItem_ID = Items.ItemID WHERE (GatheringRequests_DB.Requester_ID = @Requester_ID) AND (GatheringRequests_DB.Fulfilled = 1) ORDER BY GatheringRequests_DB.Date_Fulfilled DESC">
                                <SelectParameters>
                                    <asp:SessionParameter Name="Requester_ID" SessionField="CurrentlyViewedUserID" 
                                        Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="pnl_MyFulfilledJobs_Body_CollapsiblePanelExtender"
                runat="server" CollapseControlID="pnl_MyFulfilledJobs_Header" Collapsed="True"
                CollapsedImage="~/Resources/plus.gif" CollapsedSize="0" CollapsedText="Your Fulfilled Requests"
                Enabled="True" ExpandControlID="pnl_MyFulfilledJobs_Header" ExpandedImage="~/Resources/minus.gif"
                ExpandedSize="350" ExpandedText="Your Fulfilled Requests" ImageControlID="img_MyFulfilledJobs_Header"
                TargetControlID="pnl_MyFulfilledJobs_Body" TextLabelID="lbl_MyFulfilledJobs_Header">
            </ajaxToolkit:CollapsiblePanelExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
