<%@ Page Title="Gathering Requests - Blackjack Tools" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeBehind="Gathering.aspx.cs" Inherits="Blackjack_Tools._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <ajaxToolkit:ToolkitScriptManager ID="TSM_Gathering" runat="server">
    </ajaxToolkit:ToolkitScriptManager>
    <asp:Timer ID="TimerGathering" runat="server" Interval="300000">
    </asp:Timer>
    <asp:Label ID="lbl_Gathering_Requests" runat="server" Font-Bold="True" Font-Size="Large"
        Text="Gathering Requests"></asp:Label>
    <asp:FormView ID="FormView_InsertG_Request" runat="server" DataSourceID="SqlDataSource_GatheringUnfulfilled"
        DefaultMode="Insert" EnableModelValidation="True">
        <EditItemTemplate>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td colspan="5">
                        <br />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lbl_ItemName" runat="server" Font-Bold="True" Font-Size="Medium" Text="Item: "></asp:Label>
                        &nbsp;<asp:DropDownList ID="DDL_CraftedItems" runat="server" DataSourceID="SqlDataSourceGatheredItems"
                            DataTextField="ItemName" DataValueField="ItemID" SelectedValue='<%# Bind("ItemID") %>'>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label ID="lbl_Amount" runat="server" Font-Bold="True" Font-Size="Medium" Text="Amount: "></asp:Label>
                        <asp:TextBox ID="AmountTextBox0" runat="server" Text='<%# Bind("Amount") %>' Width="64px" />
                        <asp:RangeValidator ID="rangeValidator_Amount" runat="server" ControlToValidate="AmountTextBox0"
                            ErrorMessage="*" ForeColor="Red" MaximumValue="9999999" MinimumValue="1" Type="Integer"></asp:RangeValidator>
                        <asp:RequiredFieldValidator ID="requiredValidator_Amount" runat="server" ControlToValidate="AmountTextBox0"
                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        <ajaxToolkit:FilteredTextBoxExtender ID="AmountTextBox0_FilteredTextBoxExtender"
                            runat="server" Enabled="True" FilterType="Numbers" TargetControlID="AmountTextBox0">
                        </ajaxToolkit:FilteredTextBoxExtender>
                    </td>
                    <td colspan="2">
                        <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="Medium" Text="HQ: "></asp:Label>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("HQ") %>' />
                    </td>
                    <td>
                        <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Insert" ImageUrl="~/Resources/green_plus.png"
                            ToolTip="Make this request!" />
                    </td>
                    <td>
                        <asp:ImageButton ID="imgB_Cancel" runat="server" CausesValidation="False" CommandName="Cancel"
                            ImageUrl="~/Resources/Cancel__Red.png" ToolTip="Clear" />
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label10" runat="server" Font-Bold="True" Font-Size="Medium" Text="Reward Amount: "></asp:Label>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("RewardAmount") %>' Width="64px"></asp:TextBox>
                        <ajaxToolkit:FilteredTextBoxExtender ID="TextBox3_FilteredTextBoxExtender" runat="server"
                            Enabled="True" TargetControlID="TextBox3" ValidChars="1234567890">
                        </ajaxToolkit:FilteredTextBoxExtender>
                        <asp:RequiredFieldValidator ID="rfv_RewardAmountInvis" runat="server" ControlToValidate="TextBox3"
                            ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="rngv_RewardAmountInvis" runat="server" ControlToValidate="TextBox3"
                            ErrorMessage="*" MaximumValue="9999999" MinimumValue="1" Type="Integer"></asp:RangeValidator>
                    </td>
                    <td colspan="2">
                        <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Size="Medium" Text="Reward Type: "></asp:Label>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceRewardDB"
                            DataTextField="RewardName" DataValueField="RewardID" SelectedValue='<%# Bind("RewardID") %>'>
                        </asp:DropDownList>
                    </td>
                    <td colspan="3">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:SqlDataSource ID="SqlDataSourceGatheredItems" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                            SelectCommand="SELECT ItemID, ItemName FROM Items WHERE (CraftingGathering = 1) ORDER BY ItemName">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceRewardDB" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                            SelectCommand="SELECT * FROM [Rewards]"></asp:SqlDataSource>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
        <ItemTemplate>
        </ItemTemplate>
    </asp:FormView>
    <asp:UpdatePanel ID="UpdatePanelGathering" runat="server">
        <ContentTemplate>
            <asp:Label ID="lbl_GatheringRefresh" runat="server" Font-Size="X-Small"></asp:Label>
            <asp:GridView ID="GrdV_UnfulfilledGathering" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" DataKeyNames="Request_ID" DataSourceID="SqlDataSource_GatheringUnfulfilled"
                EnableModelValidation="True" Width="100%" OnRowCommand="GrdV_UnfulfilledGathering_RowCommand"
                OnRowDataBound="GrdV_UnfulfilledGathering_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Requester" SortExpression="Requester_Name">
                        <ItemTemplate>
                            <asp:Image ID="img_RFlair" runat="server" />
                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("Requester_Name", "default.aspx?User={0}") %>'
                                Text='<%# Eval("Requester_Name") %>'></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:HyperLinkField DataNavigateUrlFields="LinkURL" DataTextField="ItemName" HeaderText="Item Name"
                        SortExpression="ItemName" Target="_blank" />
                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" DataFormatString="{0:#,###,##0}">
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:CheckBoxField DataField="HQ" HeaderText="HQ" SortExpression="HQ" />
                    <asp:TemplateField HeaderText="Reward" SortExpression="RewardAmount">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("RewardAmount") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemStyle HorizontalAlign="Right" />
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" CssClass="currencyvalue" Text='<%# Bind("RewardAmount", "{0:#,###,##0}") %>'></asp:Label>
                            <asp:Image ID="img_Reward" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Date_Requested" DataFormatString="{0:d}" HeaderText="Date Requested"
                        SortExpression="Date_Requested" />
                    <asp:TemplateField HeaderText="Checked Out By" SortExpression="CheckedOutBy_User_ID">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CheckedOutBy_User_ID") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Image ID="img_Info" runat="server" ImageAlign="Right" ImageUrl="~/Resources/info_icon.png"
                                ToolTip='<%# Bind("Date_CheckedOut", "{0:d}") %>' />
                            <asp:Image ID="img_CFlair" runat="server" />
                            <asp:HyperLink ID="hpl_GCheckedOutBy" runat="server" NavigateUrl='<%# Bind("CheckedOutBy_Name", "default.aspx?User={0}") %>'
                                Text='<%# Bind("CheckedOutBy_Name") %>'></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Request_ID" InsertVisible="False" ReadOnly="True" SortExpression="Request_ID">
                        <ControlStyle ForeColor="#CCCCCC" />
                    </asp:BoundField>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                                Text="Update"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:ImageButton ID="imgB_Cancel" runat="server" AlternateText="Cancel Job Request"
                                CommandName="Cancel" ImageUrl="~/Resources/Cancel__Red.png" ToolTip="Cancel Job Request"
                                CausesValidation="False" />
                            <asp:ImageButton ID="imgB_Checkout" runat="server" AlternateText="Check Out this Job"
                                CommandName="Edit" ImageUrl="~/Resources/green-checkmark.png" ToolTip="Check Out This Job"
                                CausesValidation="False" />
                            <asp:ImageButton ID="imgB_Drop" runat="server" AlternateText="Drop this Job" CommandName="Delete"
                                ImageUrl="~/Resources/red-x-icon.png" Style="height: 16px" ToolTip="Drop This Job"
                                CausesValidation="False" />
                            <asp:ImageButton ID="imgB_Fulfill" runat="server" AlternateText="Mark this job as Fulfilled and ready for pickup"
                                CommandName="Update" ImageUrl="~/Resources/icon_ArrowNext.png" ToolTip="Mark This Job as Fulfilled"
                                CausesValidation="False" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Size="Medium" Text="There are currently no unfulfilled gathering jobs"></asp:Label>
                </EmptyDataTemplate>
            </asp:GridView>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="TimerGathering" EventName="Tick" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel_GatheringFulfilled" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnl_GatheringFulfilled_Header" runat="server">
                <table>
                    <tr>
                        <td>
                            <asp:Image ID="img_GatheringFulfilled_Header" runat="server" ImageUrl="~/Resources/plus.gif" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_GatheringFulfilled_Header" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnl_GatheringFulfilled_Body" runat="server" OnPreRender="pnl_GatheringFulfilled_Body_PreRender">
                <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataKeyNames="Request_ID" DataSourceID="SqlDataSource_GatheringFulfilled"
                    EnableModelValidation="True" Width="100%" OnRowCommand="GridView2_RowCommand"
                    OnRowDataBound="GridView2_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Requester" SortExpression="Requester_Name">
                            <ItemTemplate>
                                <asp:Image ID="img_RFlair" runat="server" />
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("Requester_Name", "default.aspx?User={0}") %>'
                                    Text='<%# Eval("Requester_Name") %>'></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:HyperLinkField DataNavigateUrlFields="LinkURL" DataTextField="ItemName" HeaderText="Item Name"
                            SortExpression="ItemName" Target="_blank" />
                        <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" DataFormatString="{0:#,###,##0}">
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="HQ" HeaderText="HQ" SortExpression="HQ" />
                        <asp:TemplateField HeaderText="Reward" SortExpression="RewardAmount">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("RewardAmount") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("RewardAmount", "{0:#,###,##0}") %>'
                                    CssClass="currencyvalue"></asp:Label>
                                <asp:Image ID="img_Reward" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Date_Requested" DataFormatString="{0:d}" HeaderText="Date Requested"
                            SortExpression="Date_Requested" />
                        <asp:TemplateField HeaderText="Checked Out By" SortExpression="CheckedOutBy_User_ID">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CheckedOutBy_User_ID") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="img_CheckInfo" runat="server" ImageAlign="Right" ImageUrl="~/Resources/info_icon.png"
                                    ToolTip='<%# Bind("Date_CheckedOut", "{0:d}") %>' />
                                <asp:Image ID="img_CFlair" runat="server" />
                                <asp:HyperLink ID="hpl_CheckedOutBy" runat="server" NavigateUrl='<%# Bind("CheckedOutBy_Name", "default.aspx?User={0}") %>'
                                    Text='<%# Bind("CheckedOutBy_Name") %>'></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fulfilled" SortExpression="Date_Fulfilled">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FulfilledBy_User_ID") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chk_Fulfilled" runat="server" Checked='<%# Bind("Fulfilled") %>'
                                    Enabled="False" />
                                <asp:Image ID="img_FulfillInfo" runat="server" ImageAlign="Right" ImageUrl="~/Resources/info_icon.png"
                                    ToolTip='<%# Bind("Date_Fulfilled", "{0:d}") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Verified" SortExpression="Date_Verified">
                            <EditItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Verified") %>' />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Verified") %>' Enabled="false" />
                                <asp:Image ID="Image4" runat="server" ImageAlign="Right" ImageUrl="~/Resources/info_icon.png"
                                    Visible='<%# Eval("Verified") %>' ToolTip='<%# Bind("Date_Verified", "{0:d}") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Request_ID" InsertVisible="False" ReadOnly="True" SortExpression="Request_ID" />
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:ImageButton ID="imgB_Verify" runat="server" AlternateText="Verify receipt of goods"
                                    CommandName="Update" ImageUrl="~/Resources/green-checkmark.png" ToolTip="Verify receipt of goods"
                                    CausesValidation="False" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="pnl_GatheringFulfilled_Body_CollapsiblePanelExtender"
                runat="server" Enabled="True" TargetControlID="pnl_GatheringFulfilled_Body" CollapseControlID="pnl_GatheringFulfilled_Header"
                Collapsed="True" CollapsedImage="~/Resources/plus.gif" CollapsedSize="0" CollapsedText="Fulfilled Gathering Jobs"
                ExpandControlID="pnl_GatheringFulfilled_Header" ExpandedImage="~/Resources/minus.gif"
                ExpandedSize="300" ExpandedText="THEY TOOK THE JERBS" ImageControlID="img_GatheringFulfilled_Header"
                TextLabelID="lbl_GatheringFulfilled_Header">
            </ajaxToolkit:CollapsiblePanelExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="SqlDataSource_GatheringUnfulfilled" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
        InsertCommand="DECLARE @Today DateTime;
SET @Today = GetDate();

INSERT INTO GatheringRequests_DB(Requester_ID, GatherableItem_ID, Amount, HQ, Date_Requested, RewardAmount, RewardID) VALUES (@UserName, @ItemID, @Amount, @HQ, @Today, @RewardAmount, @RewardID)"
        SelectCommand="SELECT GatheringRequests_DB.Date_Fulfilled, GatheringRequests_DB.Date_CheckedOut, GatheringRequests_DB.Date_Requested, GatheringRequests_DB.Amount, GatheringRequests_DB.Requester_ID, GatheringRequests_DB.CheckedOutBy_User_ID, GatheringRequests_DB.Fulfilled, GatheringRequests_DB.Request_ID, GatheringRequests_DB.HQ, Rewards.RewardName, GatheringRequests_DB.RewardID, GatheringRequests_DB.RewardAmount, aspnet_Users.UserName AS Requester_Name, vw_aspnet_Users.UserName AS CheckedoutBy_Name, vw_aspnet_Users.FulfilledCount AS Check_Fulfilled, aspnet_Users.FulfilledCount AS Request_Fulfilled, Items.ItemName, Items.LinkURL FROM GatheringRequests_DB INNER JOIN Rewards ON GatheringRequests_DB.RewardID = Rewards.RewardID INNER JOIN aspnet_Users ON GatheringRequests_DB.Requester_ID = aspnet_Users.UserId INNER JOIN Items ON GatheringRequests_DB.GatherableItem_ID = Items.ItemID LEFT OUTER JOIN vw_aspnet_Users ON GatheringRequests_DB.CheckedOutBy_User_ID = vw_aspnet_Users.UserId WHERE (GatheringRequests_DB.Fulfilled = 0) ORDER BY GatheringRequests_DB.Date_Requested DESC">
        <InsertParameters>
            <asp:SessionParameter Name="UserName" SessionField="UserID" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="HQ" />
            <asp:Parameter Name="ItemID" />
            <asp:Parameter Name="RewardAmount" />
            <asp:Parameter Name="RewardID" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_GatheringFulfilled" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
        SelectCommand="SELECT GatheringRequests_DB.Date_Fulfilled, GatheringRequests_DB.Date_CheckedOut, GatheringRequests_DB.Date_Requested, GatheringRequests_DB.Amount, GatheringRequests_DB.Requester_ID, GatheringRequests_DB.CheckedOutBy_User_ID, GatheringRequests_DB.Fulfilled, GatheringRequests_DB.Request_ID, GatheringRequests_DB.HQ, GatheringRequests_DB.Verified, GatheringRequests_DB.Date_Verified, Rewards.RewardName, GatheringRequests_DB.RewardID, GatheringRequests_DB.RewardAmount, aspnet_Users.UserName AS Requester_Name, vw_aspnet_Users.UserName AS CheckedoutBy_Name, aspnet_Users.FulfilledCount AS Request_Fulfilled, vw_aspnet_Users.FulfilledCount AS Check_Fulfilled, Items.ItemName, Items.LinkURL FROM GatheringRequests_DB INNER JOIN Rewards ON GatheringRequests_DB.RewardID = Rewards.RewardID INNER JOIN aspnet_Users ON GatheringRequests_DB.Requester_ID = aspnet_Users.UserId INNER JOIN Items ON GatheringRequests_DB.GatherableItem_ID = Items.ItemID LEFT OUTER JOIN vw_aspnet_Users ON GatheringRequests_DB.CheckedOutBy_User_ID = vw_aspnet_Users.UserId WHERE (GatheringRequests_DB.Fulfilled = 1) ORDER BY GatheringRequests_DB.Date_Requested DESC">
    </asp:SqlDataSource>
</asp:Content>
