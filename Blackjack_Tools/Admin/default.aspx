<%@ Page Title="Administration Page - Blackjack Tools" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Blackjack_Tools.Admin.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Administration Page</h2>
    <ajaxToolkit:ToolkitScriptManager ID="TSM_Admin" runat="server">
    </ajaxToolkit:ToolkitScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnl_Users_Header" runat="server">
                <table>
                    <tr>
                        <td>
                            <asp:Image ID="img_Users_Header" runat="server" ImageUrl="~/Resources/minus.gif" />
                            &nbsp;
                        </td>
                        <td>
                            <asp:Label ID="lbl_Users_Header" runat="server" Font-Bold="True" Font-Size="Medium"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnl_Users_Body" runat="server" OnPreRender="pnl_Users_Body_PreRender">
                <table style="width: 100%;">
                    <tr>
                        <td valign="top">
                            <asp:GridView ID="GrdV_Users" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" DataKeyNames="UserId" DataSourceID="SqlDataSource_Users"
                                EnableModelValidation="True" OnRowCommand="GrdV_Users_RowCommand" OnRowDataBound="GrdV_Users_RowDataBound">
                                <Columns>
                                    <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
                                    <asp:TemplateField HeaderText="CreateDate" SortExpression="CreateDate">
                                        <EditItemTemplate>
                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("CreateDate") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("CreateDate", "{0:d}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="LastLoginDate" DataFormatString="{0:d}" HeaderText="LastLogin"
                                        SortExpression="LastLoginDate" />
                                    <asp:TemplateField HeaderText="LastActivity" SortExpression="LastActivityDate">
                                        <EditItemTemplate>
                                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("LastActivityDate") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("LastActivityDate", "{0:d}") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CheckBoxField DataField="IsApproved" HeaderText="Approved" SortExpression="IsApproved" />
                                    <asp:TemplateField HeaderText="LockedOut" SortExpression="IsLockedOut">
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("IsLockedOut") %>'
                                                Enabled="False" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("IsLockedOut") %>'
                                                Enabled="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                                    <asp:TemplateField HeaderText="Users' Roles">
                                        <ItemTemplate>
                                            <asp:Panel ID="pnl_RolesDisplay" runat="server" Width="120px">
                                            </asp:Panel>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Comment" HeaderText="Comment" SortExpression="Comment" />
                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                                                Text="Update"></asp:LinkButton>
                                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="Cancel"></asp:LinkButton>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="imgB_UnlockUser" runat="server" CausesValidation="False" CommandName="Update"
                                                            ImageUrl="~/Resources/unlock.png" ToolTip="Unlock User" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgB_AddComment" runat="server" CausesValidation="False" CommandName="Edit"
                                                            ImageUrl="~/Resources/comment.png" ToolTip="Add User Comment" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgB_AddToRole" runat="server" CausesValidation="False" CommandName="Insert"
                                                            ImageUrl="~/Resources/green_plus.png" ToolTip="Add User to Role" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgB_RemoveFromRole" runat="server" CausesValidation="False"
                                                            CommandName="Delete" ImageUrl="~/Resources/minus.png" ToolTip="Remove User from Role" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <SelectedRowStyle BackColor="#669999" />
                            </asp:GridView>
                        </td>
                        <td valign="top">
                            <br />
                            <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Size="Medium" Text="Roles: "></asp:Label>
                            <asp:DropDownList ID="ddl_Roles" runat="server" DataSourceID="SqlDataSource_RolesManagement"
                                DataTextField="RoleName" DataValueField="RoleName">
                            </asp:DropDownList>
                            <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource_RolesManagement"
                                DefaultMode="Insert" EnableModelValidation="True">
                                <EditItemTemplate>
                                    RoleName:
                                    <asp:TextBox ID="RoleNameTextBox" runat="server" Text='<%# Bind("RoleName") %>' />
                                    <br />
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                        Text="Update" />
                                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False"
                                        CommandName="Cancel" Text="Cancel" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="RoleNameTextBox"
                                                    ErrorMessage="This Field is Required"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="Medium" Text="New Role Name"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="RoleNameTextBox" runat="server" Text='<%# Bind("RoleName") %>' />
                                                <ajaxToolkit:FilteredTextBoxExtender ID="RoleNameTextBox_FilteredTextBoxExtender"
                                                    runat="server" Enabled="True" TargetControlID="RoleNameTextBox" ValidChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ">
                                                </ajaxToolkit:FilteredTextBoxExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                                    Text="Create" />
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                    Text="Clear" />
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    &nbsp;
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    RoleName:
                                    <asp:Label ID="RoleNameLabel" runat="server" Text='<%# Bind("RoleName") %>' />
                                    <br />
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:SqlDataSource ID="SqlDataSource_RolesManagement" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                                InsertCommand="aspnet_Roles_CreateRole" InsertCommandType="StoredProcedure" SelectCommand="aspnet_Roles_GetAllRoles"
                                SelectCommandType="StoredProcedure">
                                <InsertParameters>
                                    <asp:SessionParameter Name="ApplicationName" SessionField="ApplicationName" Type="String" />
                                    <asp:Parameter Name="RoleName" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:SessionParameter Name="ApplicationName" SessionField="ApplicationName" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Label ID="lbl_UserComment" runat="server" Font-Bold="True" Font-Size="Medium"
                                Text="User Comment:"></asp:Label>
                            <asp:TextBox ID="txt_UserComment" runat="server" Height="80px" TextMode="MultiLine"
                                Width="400px"></asp:TextBox>
                            <asp:SqlDataSource ID="SqlDataSource_Users" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                                SelectCommand="SELECT vw_aspnet_MembershipUsers.Comment, vw_aspnet_MembershipUsers.UserName, vw_aspnet_MembershipUsers.IsApproved, vw_aspnet_MembershipUsers.LastActivityDate, vw_aspnet_MembershipUsers.UserId, vw_aspnet_MembershipUsers.CreateDate, vw_aspnet_MembershipUsers.IsLockedOut, aspnet_Applications.ApplicationName, vw_aspnet_MembershipUsers.LastLoginDate, vw_aspnet_MembershipUsers.Email FROM vw_aspnet_MembershipUsers INNER JOIN aspnet_Applications ON vw_aspnet_MembershipUsers.ApplicationId = aspnet_Applications.ApplicationId WHERE (aspnet_Applications.ApplicationName = @ApplicationName)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="ApplicationName" SessionField="ApplicationName" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                </table>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="pnl_Users_Body_CollapsiblePanelExtender"
                runat="server" CollapseControlID="pnl_Users_Header" CollapsedImage="~/Resources/plus.gif"
                CollapsedSize="0" CollapsedText="User Management" Enabled="True" ExpandControlID="pnl_Users_Header"
                ExpandedImage="~/Resources/minus.gif" ExpandedSize="450" ExpandedText="User Management"
                ImageControlID="img_Users_Header" TargetControlID="pnl_Users_Body" TextLabelID="lbl_Users_Header">
            </ajaxToolkit:CollapsiblePanelExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="udp_DropDowns" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnl_DropDowns_Header" runat="server">
                <table>
                    <tr>
                        <td>
                            <asp:Image ID="img_DropDowns_Header" runat="server" ImageUrl="~/Resources/minus.gif" />
                        </td>
                        <td>
                            <asp:Label ID="lbl_DropDowns_Header" runat="server" Font-Bold="True" Font-Size="Medium"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnl_DropDowns_Body" runat="server" OnPreRender="pnl_DropDowns_Body_PreRender">
                <table style="width: 100%;">
                    <tr>
                        <td valign="top">
                            <asp:Label ID="lbl_CraftedItems_Header" runat="server" Font-Bold="True" Font-Size="Medium"
                                Text="Crafted Items:"></asp:Label>
                            <asp:GridView ID="GridView_CraftedItems" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" DataSourceID="SqlDataSourceCraftedItems" EnableModelValidation="True"
                                DataKeyNames="ItemID">
                                <Columns>
                                    <asp:BoundField DataField="ItemID" HeaderText="ID" SortExpression="ItemID" />
                                    <asp:BoundField DataField="ItemName" HeaderText="ItemName" SortExpression="ItemName" />
                                    <asp:BoundField DataField="LinkURL" HeaderText="LinkURL" SortExpression="LinkURL" />
                                    <asp:BoundField DataField="ItemLevel" HeaderText="ItemLevel" SortExpression="ItemLevel" />
                                    <asp:TemplateField>
                                        <EditItemTemplate>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="imgB_Update" runat="server" CausesValidation="False" CommandName="Update"
                                                            ImageUrl="~/Resources/icon_ArrowNext.png" ToolTip="Update this item" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgB_Cancel" runat="server" CommandName="Cancel" ImageUrl="~/Resources/Cancel__Red.png"
                                                            ToolTip="Cancel editing this item" CausesValidation="False" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="imgB_EditItem" runat="server" CausesValidation="False" CommandName="Edit"
                                                            ImageUrl="~/Resources/edit.png" ToolTip="Edit this item's data" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgB_Delete" runat="server" CommandName="Delete" ImageUrl="~/Resources/red-x-icon.png"
                                                            ToolTip="Delete this item!" CausesValidation="False" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSourceCraftedItems" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                                
                                
                                SelectCommand="SELECT ItemID, ItemName, CraftingGathering, LinkURL, ItemLevel, ProfessionID FROM Items WHERE (CraftingGathering = 0)" DeleteCommand="DELETE FROM Items WHERE (ItemID = @ItemID)"
                                InsertCommand="INSERT INTO Items(ItemName, CraftingGathering, LinkURL, ItemLevel) VALUES (@ItemName, 0, @LinkURL, @ItemLevel)"
                                
                                UpdateCommand="UPDATE Items SET ItemName = @ItemName, LinkURL = @LinkURL, ItemLevel = @ItemLevel WHERE (ItemID = @ItemID)">
                                <DeleteParameters>
                                    <asp:Parameter Name="ItemID" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="ItemName" />
                                    <asp:Parameter Name="LinkURL" />
                                    <asp:Parameter Name="ItemLevel" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="ItemName" />
                                    <asp:Parameter Name="LinkURL" />
                                    <asp:Parameter Name="ItemLevel" />
                                    <asp:Parameter Name="ItemID" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td valign="top">
                            <asp:Label ID="lbl_GatheredItems_Header" runat="server" Font-Bold="True" Font-Size="Medium"
                                Text="Gathered Items:"></asp:Label>
                            <asp:GridView ID="GridViewGatheredItems" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" DataKeyNames="ItemID" DataSourceID="SqlDataSourceGatheredItems"
                                EnableModelValidation="True">
                                <Columns>
                                    <asp:BoundField DataField="ItemID" HeaderText="ID" SortExpression="ItemID" />
                                    <asp:BoundField DataField="ItemName" HeaderText="ItemName" SortExpression="ItemName" />
                                    <asp:BoundField DataField="LinkURL" HeaderText="LinkURL" SortExpression="LinkURL" />
                                    <asp:BoundField DataField="ItemLevel" HeaderText="ItemLevel" SortExpression="ItemLevel" />
                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="imgB_Update" runat="server" CausesValidation="False" CommandName="Update"
                                                            ImageUrl="~/Resources/icon_ArrowNext.png" ToolTip="Update this item" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgB_Cancel" runat="server" CommandName="Cancel" ImageUrl="~/Resources/Cancel__Red.png"
                                                            ToolTip="Cancel editing this item" CausesValidation="False" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="imgB_EditItem" runat="server" CausesValidation="False" CommandName="Edit"
                                                            ImageUrl="~/Resources/edit.png" ToolTip="Edit this item's data" />
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="imgB_Delete" runat="server" CommandName="Delete" ImageUrl="~/Resources/red-x-icon.png"
                                                            ToolTip="Delete this item!" CausesValidation="False" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSourceGatheredItems" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                                
                                
                                SelectCommand="SELECT ItemID, ItemName, CraftingGathering, LinkURL, ItemLevel, ProfessionID FROM Items WHERE (CraftingGathering = 1)" DeleteCommand="DELETE FROM Items WHERE (ItemID = @ItemID)"
                                InsertCommand="INSERT INTO Items(ItemName, CraftingGathering, LinkURL, ItemLevel) VALUES (@ItemName, 1, @LinkURL, @ItemLevel)"
                                
                                
                                UpdateCommand="UPDATE Items SET ItemName = @ItemName, LinkURL = @LinkURL, ItemLevel = @ItemLevel WHERE (ItemID = @ItemID)">
                                <DeleteParameters>
                                    <asp:Parameter Name="ItemID" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="ItemName" />
                                    <asp:Parameter Name="LinkURL" />
                                    <asp:Parameter Name="ItemLevel" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td valign="top">
                            <asp:Label ID="lbl_Professions_Header" runat="server" Font-Bold="True" Font-Size="Medium"
                                Text="Professions (To be implemented)"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <asp:FormView ID="frmV_CraftedItems" runat="server" DataKeyNames="ItemID" DataSourceID="SqlDataSourceCraftedItems"
                                DefaultMode="Insert" EnableModelValidation="True">
                                <EditItemTemplate>
                                    ItemID:
                                    <asp:Label ID="ItemIDLabel1" runat="server" Text='<%# Eval("ItemID") %>' />
                                    <br />
                                    ItemName:
                                    <asp:TextBox ID="ItemNameTextBox" runat="server" Text='<%# Bind("ItemName") %>' />
                                    <br />
                                    LinkURL:
                                    <asp:TextBox ID="LinkURLTextBox" runat="server" Text='<%# Bind("LinkURL") %>' />
                                    <br />
                                    ItemLevel:
                                    <asp:TextBox ID="ItemLevelTextBox" runat="server" Text='<%# Bind("ItemLevel") %>' />
                                    <br />
                                    Profession_ID:
                                    <asp:TextBox ID="Profession_IDTextBox" runat="server" Text='<%# Bind("Profession_ID") %>' />
                                    <br />
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                        Text="Update" />
                                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False"
                                        CommandName="Cancel" Text="Cancel" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbl_CItemName" runat="server" Font-Bold="True" Font-Size="Medium"
                                                    Text="Item Name:"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lbl_CLinkURL" runat="server" Font-Bold="True" Font-Size="Medium" Text="XIVDB URL:"
                                                    ToolTip="Link to the item page"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lbl_ItemLevel" runat="server" Font-Bold="True" Font-Size="Medium"
                                                    Text="Item Level" ToolTip="This is either the level of an item's recipe or the level in which it displays on the gathering node"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="ItemNameTextBox" runat="server" Text='<%# Bind("ItemName") %>' />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="LinkURLTextBox" runat="server" Text='<%# Bind("LinkURL") %>' />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="ItemLevelTextBox" runat="server" Text='<%# Bind("ItemLevel") %>' />
                                            </td>
                                            <td>
                                                <asp:ImageButton ID="imgB_Insert" runat="server" CommandName="Insert" ImageUrl="~/Resources/green_plus.png"
                                                    CausesValidation="False" />
                                            </td>
                                            <td>
                                                <asp:ImageButton ID="imgB_Cancel" runat="server" CommandName="Cancel" ImageUrl="~/Resources/Cancel__Red.png"
                                                    CausesValidation="False" />
                                            </td>
                                        </tr>
                                    </table>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    ItemID:
                                    <asp:Label ID="ItemIDLabel" runat="server" Text='<%# Eval("ItemID") %>' />
                                    <br />
                                    ItemName:
                                    <asp:Label ID="ItemNameLabel" runat="server" Text='<%# Bind("ItemName") %>' />
                                    <br />
                                    LinkURL:
                                    <asp:Label ID="LinkURLLabel" runat="server" Text='<%# Bind("LinkURL") %>' />
                                    <br />
                                    ItemLevel:
                                    <asp:Label ID="ItemLevelLabel" runat="server" Text='<%# Bind("ItemLevel") %>' />
                                    <br />
                                    Profession_ID:
                                    <asp:Label ID="Profession_IDLabel" runat="server" Text='<%# Bind("Profession_ID") %>' />
                                    <br />
                                </ItemTemplate>
                            </asp:FormView>
                        </td>
                        <td valign="top">
                            <asp:FormView ID="frmV_GatheredItems" runat="server" DataKeyNames="ItemID" DataSourceID="SqlDataSourceGatheredItems"
                                DefaultMode="Insert" EnableModelValidation="True">
                                <EditItemTemplate>
                                    ItemID:
                                    <asp:Label ID="ItemIDLabel2" runat="server" Text='<%# Eval("ItemID") %>' />
                                    <br />
                                    ItemName:
                                    <asp:TextBox ID="ItemNameTextBox0" runat="server" Text='<%# Bind("ItemName") %>' />
                                    <br />
                                    LinkURL:
                                    <asp:TextBox ID="LinkURLTextBox0" runat="server" Text='<%# Bind("LinkURL") %>' />
                                    <br />
                                    ItemLevel:
                                    <asp:TextBox ID="ItemLevelTextBox0" runat="server" Text='<%# Bind("ItemLevel") %>' />
                                    <br />
                                    Profession_ID:
                                    <asp:TextBox ID="Profession_IDTextBox0" runat="server" Text='<%# Bind("Profession_ID") %>' />
                                    <br />
                                    <asp:LinkButton ID="UpdateButton0" runat="server" CausesValidation="True" CommandName="Update"
                                        Text="Update" />
                                    &nbsp;<asp:LinkButton ID="UpdateCancelButton0" runat="server" CausesValidation="False"
                                        CommandName="Cancel" Text="Cancel" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <table style="width: 100%;">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbl_CItemName0" runat="server" Font-Bold="True" Font-Size="Medium"
                                                    Text="Item Name:"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lbl_CLinkURL0" runat="server" Font-Bold="True" Font-Size="Medium"
                                                    Text="XIVDB URL:" ToolTip="Link to the item page"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="lbl_ItemLevel0" runat="server" Font-Bold="True" Font-Size="Medium"
                                                    Text="Item Level" ToolTip="This is either the level of an item's recipe or the level in which it displays on the gathering node"></asp:Label>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="ItemNameTextBox1" runat="server" Text='<%# Bind("ItemName") %>' />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="LinkURLTextBox1" runat="server" Text='<%# Bind("LinkURL") %>' />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="ItemLevelTextBox1" runat="server" Text='<%# Bind("ItemLevel") %>' />
                                            </td>
                                            <td>
                                                <asp:ImageButton ID="imgB_Insert0" runat="server" CausesValidation="False" CommandName="Insert"
                                                    ImageUrl="~/Resources/green_plus.png" />
                                            </td>
                                            <td>
                                                <asp:ImageButton ID="imgB_Cancel0" runat="server" CausesValidation="False" CommandName="Cancel"
                                                    ImageUrl="~/Resources/Cancel__Red.png" />
                                            </td>
                                        </tr>
                                    </table>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    ItemID:
                                    <asp:Label ID="ItemIDLabel3" runat="server" Text='<%# Eval("ItemID") %>' />
                                    <br />
                                    ItemName:
                                    <asp:Label ID="ItemNameLabel0" runat="server" Text='<%# Bind("ItemName") %>' />
                                    <br />
                                    LinkURL:
                                    <asp:Label ID="LinkURLLabel0" runat="server" Text='<%# Bind("LinkURL") %>' />
                                    <br />
                                    ItemLevel:
                                    <asp:Label ID="ItemLevelLabel0" runat="server" Text='<%# Bind("ItemLevel") %>' />
                                    <br />
                                    Profession_ID:
                                    <asp:Label ID="Profession_IDLabel0" runat="server" Text='<%# Bind("Profession_ID") %>' />
                                    <br />
                                </ItemTemplate>
                            </asp:FormView>
                        </td>
                        <td valign="top">
                            &nbsp;
                            <asp:Button ID="btn_Flair" runat="server" CausesValidation="False" 
                                onclick="btn_Flair_Click" Text="Recalculate Flair" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="pnl_DropDowns_Body_CollapsiblePanelExtender"
                runat="server" CollapseControlID="pnl_DropDowns_Header" CollapsedImage="~/Resources/plus.gif"
                CollapsedSize="0" CollapsedText="Item and Drop Down Management" Enabled="True"
                ExpandControlID="pnl_DropDowns_Header" ExpandedImage="~/Resources/minus.gif"
                ExpandedSize="350" ExpandedText="Item and Drop Down Management" ImageControlID="img_DropDowns_Header"
                TargetControlID="pnl_DropDowns_Body" TextLabelID="lbl_DropDowns_Header">
            </ajaxToolkit:CollapsiblePanelExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
