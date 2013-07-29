<%@ Page Title="Crafting Requests - Blackjack Tools" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Crafting.aspx.cs" Inherits="Blackjack_Tools._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <ajaxToolkit:ToolkitScriptManager ID="TSM_Crafting" runat="server">
    </ajaxToolkit:ToolkitScriptManager>
    <asp:Timer ID="TimerCrafting" runat="server" Interval="300000">
    </asp:Timer>
    <asp:Label ID="lbl_Crafting_Header" runat="server" Font-Bold="True" 
        Font-Size="Large" Text="Crafting Requests"></asp:Label>
    <asp:FormView ID="FormView_InsertC_Request" runat="server" DataSourceID="SqlDataSource_CraftingUnfulfilled"
        DefaultMode="Insert" EnableModelValidation="True">
        <EditItemTemplate>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table>
                <tr>
                    <td>
                        &nbsp;</td>
                    <td colspan="4">
                        <br />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label_ItemName" runat="server" Font-Bold="True" Font-Size="Medium"
                            Text="Item: "></asp:Label>
                        <asp:DropDownList ID="DropDownList1" runat="server" 
                            DataSourceID="SqlDataSourceCraftedItemDB" DataTextField="ItemName" 
                            DataValueField="ItemID" SelectedValue='<%# Bind("ItemID") %>'>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="Medium" 
                            Text="Amount: "></asp:Label>
                        <asp:TextBox ID="txt_Amount" runat="server" Text='<%# Bind("Amount") %>' 
                            Width="64px"></asp:TextBox>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" 
                            ControlToValidate="txt_Amount" ErrorMessage="*" MaximumValue="9999999" 
                            MinimumValue="1" Type="Integer"></asp:RangeValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                            ControlToValidate="txt_Amount" ErrorMessage="*"></asp:RequiredFieldValidator>                        
                        <ajaxToolkit:FilteredTextBoxExtender ID="txt_Amount_FilteredTextBoxExtender" 
                            runat="server" Enabled="True" TargetControlID="txt_Amount" ValidChars="1234567890">
                        </ajaxToolkit:FilteredTextBoxExtender>
                    </td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Medium" 
                            Text="HQ: "></asp:Label>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("HQ") %>' />
                    </td>
                    <td>
                        <asp:ImageButton ID="imgB_Insert" runat="server" CommandName="Insert" 
                            ImageUrl="~/Resources/green_plus.png" ToolTip="Make this request!" />
                    </td>
                    <td>
                        <asp:ImageButton ID="ImageButton2" runat="server" CommandName="Cancel" 
                            ImageUrl="~/Resources/Cancel__Red.png" ToolTip="Clear" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Size="Medium" 
                            Text="Reward Amount: "></asp:Label>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("RewardAmount") %>' 
                            Width="64px"></asp:TextBox>
                        <ajaxToolkit:FilteredTextBoxExtender ID="TextBox4_FilteredTextBoxExtender" 
                            runat="server" Enabled="True" TargetControlID="TextBox4" 
                            ValidChars="1234567890">
                        </ajaxToolkit:FilteredTextBoxExtender>
                        <asp:RangeValidator ID="RangeValidator2" runat="server" 
                            ControlToValidate="TextBox4" ErrorMessage="*" MaximumValue="9999999" 
                            MinimumValue="1" Type="Integer"></asp:RangeValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                            ControlToValidate="TextBox4" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </td>
                    <td colspan="3">
                        <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Size="Medium" 
                            Text="Reward Type: "></asp:Label>
                        <asp:DropDownList ID="DropDownList2" runat="server" 
                            DataSourceID="SqlDataSourceRewardDB" DataTextField="RewardName" 
                            DataValueField="RewardID" SelectedValue='<%# Bind("RewardID") %>'>
                        </asp:DropDownList>
                    </td>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="5">
                        <asp:SqlDataSource ID="SqlDataSourceCraftedItemDB" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>" 
                            SelectCommand="SELECT [ItemID], [ItemName] FROM [CraftedItems]">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSourceRewardDB" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>" 
                            SelectCommand="SELECT [RewardID], [RewardName] FROM [Rewards]">
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
        <ItemTemplate>
        </ItemTemplate>
    </asp:FormView>
    <asp:UpdatePanel ID="UpdatePanelCrafting" runat="server">
        <ContentTemplate>
            <asp:Label ID="lbl_CraftingRefresh" runat="server" Font-Size="X-Small"></asp:Label>
            <asp:GridView ID="GridView_Crafting" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" DataKeyNames="Request_ID" DataSourceID="SqlDataSource_CraftingUnfulfilled"
                EnableModelValidation="True"
                Width="100%" onrowcommand="GridView_Crafting_RowCommand" 
                onrowdatabound="GridView_Crafting_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Requester" SortExpression="Requester_Name">
                        <ItemTemplate>
                            <asp:Image ID="img_RFlair" runat="server" />
                            <asp:HyperLink ID="HyperLink1" runat="server" 
                                NavigateUrl='<%# Eval("Requester_Name", "default.aspx?User={0}") %>' 
                                Text='<%# Eval("Requester_Name") %>'></asp:HyperLink>
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
                        <ItemStyle HorizontalAlign="Right" />
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" 
                                Text='<%# Bind("RewardAmount", "{0:#,###,##0}") %>' CssClass="currencyvalue"></asp:Label>
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
                            <asp:Image ID="img_Info" runat="server" ImageAlign="Right" 
                                ImageUrl="~/Resources/info_icon.png" 
                                ToolTip='<%# Bind("Date_CheckedOut", "{0:d}") %>' />
                            <asp:Image ID="img_CFlair" runat="server" />
                            <asp:HyperLink ID="hpl_CheckedOutBy" runat="server" 
                                NavigateUrl='<%# Eval("CheckedOutBy_Name", "default.aspx?User={0}") %>' 
                                Text='<%# Eval("CheckedOutBy_Name") %>'></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Request_ID" InsertVisible="False" ReadOnly="True" SortExpression="Request_ID" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                                        <asp:ImageButton ID="imgB_Cancel" runat="server" CommandName="Cancel" 
                                            ImageUrl="~/Resources/Cancel__Red.png" ToolTip="Cancel Job Request" 
                                            CausesValidation="False" />
                                        <asp:ImageButton ID="imgB_CheckOut" runat="server" CommandName="Edit" 
                                            ImageUrl="~/Resources/green-checkmark.png" ToolTip="Check Out This Job" 
                                            CausesValidation="False" />
                                        <asp:ImageButton ID="imgB_Drop" runat="server" CommandName="Delete" 
                                            ImageUrl="~/Resources/red-x-icon.png" ToolTip="Drop This Job" 
                                            CausesValidation="False" />
                                        <asp:ImageButton ID="imgB_Fulfill" runat="server" CommandName="Update" 
                                            ImageUrl="~/Resources/icon_ArrowNext.png" 
                                            ToolTip="Mark This Job as Fulfilled and Ready for pickup" 
                                            CausesValidation="False" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Size="Medium" 
                        Text="There are currently no unfulfilled crafting jobs"></asp:Label>
                </EmptyDataTemplate>
            </asp:GridView>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="TimerCrafting" EventName="Tick" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnl_CraftingFulfilled_Header" runat="server">
                <table>
                    <tr>
                        <td>
                            <asp:Image ID="img_CraftingFulfilled_Header" runat="server" ImageUrl="~/Resources/plus.gif" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_CraftingFulfilled_Header" runat="server" Font-Bold="True"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnl_CraftingFulfilled_Body" runat="server" 
                onprerender="pnl_CraftingFulfilled_Body_PreRender">
                <asp:GridView ID="GridView_CraftingFulfilled" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataKeyNames="Request_ID" DataSourceID="SqlDataSource_CraftingFulfilled"
                    EnableModelValidation="True" Width="100%" 
                    onrowcommand="GridView_CraftingFulfilled_RowCommand" 
                    onrowdatabound="GridView_CraftingFulfilled_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Requester" SortExpression="Requester_Name">
                            <ItemTemplate>
                                <asp:Image ID="img_RFlair" runat="server" />
                                <asp:HyperLink ID="HyperLink1" runat="server" 
                                    NavigateUrl='<%# Eval("Requester_Name", "default.aspx?User={0}") %>' 
                                    Text='<%# Eval("Requester_Name") %>'></asp:HyperLink>
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
                                <asp:Image ID="Image2" runat="server" ImageAlign="Right" 
                                    ImageUrl="~/Resources/info_icon.png" 
                                    ToolTip='<%# Bind("Date_CheckedOut", "{0:d}") %>' />
                                <asp:Image ID="img_CFlair" runat="server" />
                                <asp:HyperLink ID="hpl_CheckedOutBy" runat="server" 
                                    NavigateUrl='<%# Bind("CheckedOutBy_Name", "default.aspx?User={0}") %>' 
                                    Text='<%# Bind("CheckedOutBy_Name") %>'></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fulfilled" SortExpression="Date_Fulfilled">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FulfilledBy_User_ID") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("Fulfilled") %>' 
                                    Enabled="False" />
                                <asp:Image ID="Image3" runat="server" ImageAlign="Right" 
                                    ImageUrl="~/Resources/info_icon.png" 
                                    ToolTip='<%# Bind("Date_Fulfilled", "{0:d}") %>' 
                                    Visible='<%# Bind("Fulfilled") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Verified" SortExpression="Date_Verified">
                            <EditItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Verified") %>' />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("Verified") %>' 
                                    Enabled="false" />
                                <asp:Image ID="Image4" runat="server" ImageAlign="Right" 
                                    ImageUrl="~/Resources/info_icon.png" Visible='<%# Eval("Verified") %>' 
                                    ToolTip='<%# Bind("Date_Verified", "{0:d}") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Request_ID" InsertVisible="False" ReadOnly="True" 
                            SortExpression="Request_ID" />
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:ImageButton ID="imgB_Verify" runat="server" CausesValidation="False" 
                                    CommandName="Update" ImageUrl="~/Resources/green-checkmark.png" 
                                    ToolTip="Verify Receipt of Goods" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="pnl_CraftingFulfilled_Body_CollapsiblePanelExtender"
                runat="server" CollapseControlID="pnl_CraftingFulfilled_Header" Collapsed="True"
                CollapsedImage="~/Resources/plus.gif" CollapsedSize="0" CollapsedText="Fulfilled Crafting Jobs"
                Enabled="True" ExpandControlID="pnl_CraftingFulfilled_Header" ExpandedImage="~/Resources/minus.gif"
                ExpandedText="Fulfilled Crafting Jobs" ImageControlID="img_CraftingFulfilled_Header"
                TargetControlID="pnl_CraftingFulfilled_Body" TextLabelID="lbl_CraftingFulfilled_Header">
            </ajaxToolkit:CollapsiblePanelExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_CraftingUnfulfilled" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
        InsertCommand="DECLARE @Today DateTime;
SET @Today = GetDate();

INSERT INTO CraftingRequests_DB(Requester_ID, CraftableItem_ID, HQ, Date_Requested, Amount, RewardAmount, RewardID) VALUES (@UserName, @ItemID, @HQ, @Today, @Amount, @RewardAmount, @RewardID)"
        
        
        
        
        
        
        
        
        SelectCommand="SELECT CraftingRequests_DB.Requester_ID, CraftingRequests_DB.Date_Requested, CraftingRequests_DB.CheckedOutBy_User_ID, CraftingRequests_DB.Date_CheckedOut, CraftingRequests_DB.Date_Fulfilled, CraftingRequests_DB.Request_ID, CraftingRequests_DB.HQ, CraftingRequests_DB.Amount, CraftedItems.ItemName, CraftedItems.LinkURL, Rewards.RewardName, CraftingRequests_DB.RewardAmount, CraftingRequests_DB.RewardID, CraftingRequests_DB.Fulfilled, aspnet_Users.UserName AS Requester_Name, vw_aspnet_Users.UserName AS CheckedoutBy_Name, aspnet_Users.FulfilledCount AS Request_Fulfilled, vw_aspnet_Users.FulfilledCount AS Check_Fulfilled FROM CraftingRequests_DB INNER JOIN CraftedItems ON CraftingRequests_DB.CraftableItem_ID = CraftedItems.ItemID INNER JOIN Rewards ON CraftingRequests_DB.RewardID = Rewards.RewardID INNER JOIN aspnet_Users ON CraftingRequests_DB.Requester_ID = aspnet_Users.UserId LEFT OUTER JOIN vw_aspnet_Users ON CraftingRequests_DB.CheckedOutBy_User_ID = vw_aspnet_Users.UserId WHERE (CraftingRequests_DB.Fulfilled = 0) ORDER BY CraftingRequests_DB.Date_Requested DESC">
        <InsertParameters>
            <asp:SessionParameter Name="UserName" SessionField="UserID" />
            <asp:Parameter Name="HQ" />
            <asp:Parameter Name="Amount" />
            <asp:Parameter Name="ItemID" />
            <asp:Parameter Name="RewardAmount" />
            <asp:Parameter Name="RewardID" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_CraftingFulfilled" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
        
        
        
        
        
        
        
        
        SelectCommand="SELECT CraftingRequests_DB.Requester_ID, CraftingRequests_DB.Date_Requested, CraftingRequests_DB.CheckedOutBy_User_ID, CraftingRequests_DB.Date_CheckedOut, CraftingRequests_DB.Date_Fulfilled, CraftingRequests_DB.Request_ID, CraftingRequests_DB.HQ, CraftingRequests_DB.Verified, CraftingRequests_DB.Date_Verified, CraftingRequests_DB.Amount, CraftedItems.ItemName, CraftedItems.LinkURL, Rewards.RewardName, CraftingRequests_DB.RewardAmount, CraftingRequests_DB.RewardID, CraftingRequests_DB.Fulfilled, aspnet_Users.UserName AS Requester_Name, vw_aspnet_Users.UserName AS CheckedoutBy_Name, aspnet_Users.FulfilledCount AS Request_Fulfilled, vw_aspnet_Users.FulfilledCount AS Check_Fulfilled FROM CraftingRequests_DB INNER JOIN CraftedItems ON CraftingRequests_DB.CraftableItem_ID = CraftedItems.ItemID INNER JOIN Rewards ON CraftingRequests_DB.RewardID = Rewards.RewardID INNER JOIN aspnet_Users ON CraftingRequests_DB.Requester_ID = aspnet_Users.UserId LEFT OUTER JOIN vw_aspnet_Users ON CraftingRequests_DB.CheckedOutBy_User_ID = vw_aspnet_Users.UserId WHERE (CraftingRequests_DB.Fulfilled = 1) ORDER BY CraftingRequests_DB.Date_Requested DESC">
    </asp:SqlDataSource>
</asp:Content>
