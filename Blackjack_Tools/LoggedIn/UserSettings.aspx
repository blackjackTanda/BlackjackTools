<%@ Page Title="Home Page - Blackjack Tools" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeBehind="UserSettings.aspx.cs" Inherits="Blackjack_Tools._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <ajaxToolkit:ToolkitScriptManager ID="TSM_Settings" runat="server">
    </ajaxToolkit:ToolkitScriptManager>
    <asp:UpdatePanel ID="upnl_Settings" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnl_Settings_Header" runat="server">
                <asp:Image ID="img_Settings_Header" runat="server" ImageUrl="~/Resources/minus.gif" />
                <asp:Label ID="lbl_Settings_Header" runat="server"></asp:Label>
            </asp:Panel>
            <asp:Panel ID="pnl_Settings_Body" runat="server">
                <asp:FormView ID="frmv_Settings" runat="server" DataSourceID="SqlDataSourceSettings"
                    DefaultMode="Edit" EnableModelValidation="True" 
                    onitemupdated="frmv_Settings_ItemUpdated">
                    <EditItemTemplate>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:CheckBox ID="chkb_DisplayFlair" runat="server" Checked='<%# Bind("DisplayFlair") %>'
                                        Text="Show me user's flair" />
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="chkb_EmailNotifications" runat="server" Checked='<%# Bind("EmailNotifications") %>'
                                        Enabled="False" Text="Send me email notifications of events." 
                                        ToolTip="Email notification is coming soon!" />
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_Server" runat="server" Text="Your Server:"></asp:Label>
                                    <asp:DropDownList ID="ddl_Servers" runat="server" DataSourceID="SqlDataSourceServers"
                                        DataTextField="ServerName" DataValueField="ServerID" SelectedValue='<%# Bind("ServerID") %>'>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_Lodestone" runat="server" Text="Lodestone ID:"></asp:Label>
                                    <br />
                                    <asp:TextBox ID="txt_LodestoneID" runat="server" 
                                        Text='<%# Bind("LodestoneID") %>' Enabled="False" ToolTip="Not yet implemented"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:ImageButton ID="imgB_Update" runat="server" CommandName="Update" 
                                        ImageUrl="~/Resources/green-checkmark.png" ToolTip="Update your settings." />
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        DisplayFlair:
                        <asp:CheckBox ID="DisplayFlairCheckBox" runat="server" Checked='<%# Bind("DisplayFlair") %>' />
                        <br />
                        ServerID:
                        <asp:TextBox ID="ServerIDTextBox" runat="server" Text='<%# Bind("ServerID") %>' />
                        <br />
                        LodestoneID:
                        <asp:TextBox ID="LodestoneIDTextBox" runat="server" Text='<%# Bind("LodestoneID") %>' />
                        <br />
                        EmailNotifications:
                        <asp:CheckBox ID="EmailNotificationsCheckBox" runat="server" Checked='<%# Bind("EmailNotifications") %>' />
                        <br />
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                            Text="Insert" />
                        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False"
                            CommandName="Cancel" Text="Cancel" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        DisplayFlair:
                        <asp:CheckBox ID="DisplayFlairCheckBox" runat="server" Checked='<%# Bind("DisplayFlair") %>'
                            Enabled="false" />
                        <br />
                        ServerID:
                        <asp:Label ID="ServerIDLabel" runat="server" Text='<%# Bind("ServerID") %>' />
                        <br />
                        LodestoneID:
                        <asp:Label ID="LodestoneIDLabel" runat="server" Text='<%# Bind("LodestoneID") %>' />
                        <br />
                        EmailNotifications:
                        <asp:CheckBox ID="EmailNotificationsCheckBox" runat="server" Checked='<%# Bind("EmailNotifications") %>'
                            Enabled="false" />
                        <br />
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="SqlDataSourceSettings" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                    
                    SelectCommand="SELECT DisplayFlair, ServerID, LodestoneID, EmailNotifications FROM aspnet_Users WHERE (UserId = @UserID)" 
                    UpdateCommand="UPDATE aspnet_Users SET DisplayFlair = @DisplayFlair, ServerID = @ServerID, LodestoneID = @LodestoneID, EmailNotifications = @EmailNotifications WHERE (UserId = @UserID)">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="UserID" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="DisplayFlair" />
                        <asp:Parameter Name="ServerID" />
                        <asp:Parameter Name="LodestoneID" />
                        <asp:Parameter Name="EmailNotifications" />
                        <asp:SessionParameter Name="UserID" SessionField="UserID" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceServers" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                    SelectCommand="SELECT [ServerID], [ServerName] FROM [Servers]"></asp:SqlDataSource>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="pnl_Settings_Body_CollapsiblePanelExtender"
                runat="server" CollapseControlID="pnl_Settings_Header" CollapsedImage="~/Resources/plus.gif"
                CollapsedText="Your Settings" Enabled="True" ExpandControlID="pnl_Settings_Header"
                ExpandedImage="~/Resources/minus.gif" ExpandedText="Your Settings" ImageControlID="img_Settings_Header"
                TargetControlID="pnl_Settings_Body" TextLabelID="lbl_Settings_Header">
            </ajaxToolkit:CollapsiblePanelExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="upnl_Filters" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnl_Filters_Header" runat="server">
                <asp:Image ID="img_Filters_Header" runat="server" ImageUrl="~/Resources/plus.gif" />
                <asp:Label ID="lbl_Filters_Header" runat="server" ToolTip="Filters govern which email notifications of new requests you receive."></asp:Label>
            </asp:Panel>
            <asp:Panel ID="pnl_Filters_Body" runat="server">
                <asp:GridView ID="grdv_Filters" runat="server" AutoGenerateColumns="False" DataKeyNames="FilterID"
                    DataSourceID="SqlDataSourceFilters" EnableModelValidation="True" OnRowDataBound="grdv_Filters_RowDataBound"
                    Width="75%">
                    <Columns>
                        <asp:BoundField DataField="ProfessionName" HeaderText="Profession" SortExpression="ProfessionName" />
                        <asp:BoundField DataField="ItemLevel" HeaderText="Item Level" SortExpression="ItemLevel" />
                        <asp:TemplateField HeaderText="Specific Item" SortExpression="ItemName">
                            <ItemTemplate>
                                <asp:HyperLink ID="hpl_ItemName" runat="server" NavigateUrl='<%# Eval("LinkURL") %>'
                                    Target="_blank" Text='<%# Eval("ItemName") %>'></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="AmountLow" HeaderText="Lowest Amount:" SortExpression="AmountLow" />
                        <asp:BoundField DataField="AmountHigh" HeaderText="Highest Amount" SortExpression="AmountHigh" />
                    </Columns>
                    <EmptyDataTemplate>
                        <table style="width: 100%;">
                            <tr>
                                <td align="center" width="28%">
                                    <asp:Label ID="lbl_Profession" runat="server" Text="Profession"></asp:Label>
                                </td>
                                <td align="center" width="10%">
                                    <asp:Label ID="lbl_ItemLevel" runat="server" Text="Item Level"></asp:Label>
                                </td>
                                <td align="center" width="20%">
                                    <asp:Label ID="lbl_ItemName" runat="server" Text="Item Name"></asp:Label>
                                </td>
                                <td align="center" width="12%">
                                    <asp:Label ID="lbl_LowestAmount" runat="server" Text="Lowest Amount"></asp:Label>
                                </td>
                                <td align="center" width="12%">
                                    <asp:Label ID="lbl_HighestAmount" runat="server" Text="Highest Amount"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:FormView ID="frmv_Filters" runat="server" DataKeyNames="FilterID" DataSourceID="SqlDataSourceFilters"
                    DefaultMode="Insert" EnableModelValidation="True" Width="75%">
                    <EditItemTemplate>
                        UserID:
                        <asp:TextBox ID="UserIDTextBox" runat="server" Text='<%# Bind("UserID") %>' />
                        <br />
                        FilterID:
                        <asp:Label ID="FilterIDLabel1" runat="server" Text='<%# Eval("FilterID") %>' />
                        <br />
                        ProfessionID:
                        <asp:TextBox ID="ProfessionIDTextBox" runat="server" Text='<%# Bind("ProfessionID") %>' />
                        <br />
                        ItemLevel:
                        <asp:TextBox ID="ItemLevelTextBox" runat="server" Text='<%# Bind("ItemLevel") %>' />
                        <br />
                        ItemID:
                        <asp:TextBox ID="ItemIDTextBox" runat="server" Text='<%# Bind("ItemID") %>' />
                        <br />
                        AmountLow:
                        <asp:TextBox ID="AmountLowTextBox" runat="server" Text='<%# Bind("AmountLow") %>' />
                        <br />
                        AmountHigh:
                        <asp:TextBox ID="AmountHighTextBox" runat="server" Text='<%# Bind("AmountHigh") %>' />
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
                                    <asp:DropDownList ID="ddl_Professions" runat="server" DataSourceID="SqlDataSourceProfessions"
                                        DataTextField="ProfessionName" DataValueField="ProfessionID" SelectedValue='<%# Bind("ProfessionID") %>'>
                                        <asp:ListItem Value="0">&lt;No Specific Profession&gt;</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_ItemLevel" runat="server" Text='<%# Bind("ItemLevel") %>' ToolTip="This is level of a recipe, or the level of a gathered item on a node."
                                        Width="25px"></asp:TextBox>
                                    <asp:RangeValidator ID="rngv_ItemLevel" runat="server" ControlToValidate="txt_ItemLevel"
                                        ErrorMessage="*" MaximumValue="50" MinimumValue="1"></asp:RangeValidator>
                                    <ajaxToolkit:FilteredTextBoxExtender ID="txt_ItemLevel_FilteredTextBoxExtender" runat="server"
                                        Enabled="True" FilterType="Numbers" TargetControlID="txt_ItemLevel">
                                    </ajaxToolkit:FilteredTextBoxExtender>
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceItems"
                                        DataTextField="ItemName" DataValueField="ItemID" SelectedValue='<%# Bind("ItemID") %>'>
                                        <asp:ListItem Value="1001">&lt;No Specific Item&gt;</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_LowestAmount" runat="server" Text='<%# Bind("AmountLow") %>'
                                        Width="50px"></asp:TextBox>
                                    <asp:RangeValidator ID="rng_LowestAmount" runat="server" ControlToValidate="txt_LowestAmount"
                                        ErrorMessage="*" MaximumValue="9999999" MinimumValue="0" Width="0px"></asp:RangeValidator>
                                    <ajaxToolkit:FilteredTextBoxExtender ID="txt_LowestAmount_FilteredTextBoxExtender"
                                        runat="server" Enabled="True" FilterType="Numbers" TargetControlID="txt_LowestAmount">
                                    </ajaxToolkit:FilteredTextBoxExtender>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_HighestAmount" runat="server" Text='<%# Bind("AmountHigh") %>'
                                        Width="50px"></asp:TextBox>
                                    <ajaxToolkit:FilteredTextBoxExtender ID="txt_HighestAmount_FilteredTextBoxExtender"
                                        runat="server" Enabled="True" FilterType="Numbers" TargetControlID="txt_HighestAmount">
                                    </ajaxToolkit:FilteredTextBoxExtender>
                                    <asp:RangeValidator ID="rngv_HighestAmount" runat="server" ControlToValidate="txt_HighestAmount"
                                        ErrorMessage="*" MaximumValue="9999999" MinimumValue="0" Width="0px"></asp:RangeValidator>
                                    <asp:CompareValidator ID="cmpv_HighestAmount" runat="server" ControlToCompare="txt_LowestAmount"
                                        ControlToValidate="txt_HighestAmount" ErrorMessage="*" Operator="GreaterThan"
                                        Type="Integer" Width="0px"></asp:CompareValidator>
                                </td>
                                <td>
                                    <asp:ImageButton ID="imgB_Insert" runat="server" CommandName="Insert" ImageUrl="~/Resources/green_plus.png" />
                                    <asp:ImageButton ID="imgB_Cancel" runat="server" CommandName="Cancel" ImageUrl="~/Resources/Cancel__Red.png" />
                                </td>
                            </tr>
                        </table>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        UserID:
                        <asp:Label ID="UserIDLabel" runat="server" Text='<%# Bind("UserID") %>' />
                        <br />
                        FilterID:
                        <asp:Label ID="FilterIDLabel" runat="server" Text='<%# Eval("FilterID") %>' />
                        <br />
                        ProfessionID:
                        <asp:Label ID="ProfessionIDLabel" runat="server" Text='<%# Bind("ProfessionID") %>' />
                        <br />
                        ItemLevel:
                        <asp:Label ID="ItemLevelLabel" runat="server" Text='<%# Bind("ItemLevel") %>' />
                        <br />
                        ItemID:
                        <asp:Label ID="ItemIDLabel" runat="server" Text='<%# Bind("ItemID") %>' />
                        <br />
                        AmountLow:
                        <asp:Label ID="AmountLowLabel" runat="server" Text='<%# Bind("AmountLow") %>' />
                        <br />
                        AmountHigh:
                        <asp:Label ID="AmountHighLabel" runat="server" Text='<%# Bind("AmountHigh") %>' />
                        <br />
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="SqlDataSourceFilters" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                    SelectCommand="SELECT Filters.UserID, Filters.FilterID, Filters.ProfessionID, Filters.ItemLevel, Filters.ItemID, Filters.AmountLow, Filters.AmountHigh, Items.ItemName, Professions.ProfessionName, Items.LinkURL FROM Filters INNER JOIN Items ON Filters.ItemID = Items.ItemID INNER JOIN Professions ON Filters.ProfessionID = Professions.ProfessionID WHERE (Filters.UserID = @UserID)"
                    InsertCommand="INSERT INTO Filters(ProfessionID, ItemLevel, UserID, ItemID, AmountLow, AmountHigh) VALUES (@ProfessionID, @ItemLevel, @UserID, @ItemID, @AmountLow, @AmountHigh)">
                    <InsertParameters>
                        <asp:Parameter Name="ProfessionID" />
                        <asp:Parameter Name="ItemLevel" />
                        <asp:SessionParameter Name="UserID" SessionField="UserID" />
                        <asp:Parameter Name="ItemID" />
                        <asp:Parameter Name="AmountLow" />
                        <asp:Parameter Name="AmountHigh" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="UserID" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceProfessions" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                    
                    SelectCommand="SELECT ProfessionID, ProfessionName FROM Professions ORDER BY ProfessionName"></asp:SqlDataSource>
                <asp:SqlDataSource ID="SqlDataSourceItems" runat="server" ConnectionString="<%$ ConnectionStrings:BlackjackTools_DB %>"
                    SelectCommand="SELECT [ItemID], [ItemName] FROM [Items] ORDER BY [ItemName]">
                </asp:SqlDataSource>
            </asp:Panel>
            <ajaxToolkit:CollapsiblePanelExtender ID="pnl_Filters_Body_CollapsiblePanelExtender"
                runat="server" CollapseControlID="pnl_Filters_Header" CollapsedImage="~/Resources/plus.gif"
                CollapsedText="Your Filters" Enabled="True" ExpandControlID="pnl_Filters_Header"
                ExpandedImage="~/Resources/minus.gif" ExpandedText="Your Filters" ImageControlID="img_Filters_Header"
                TargetControlID="pnl_Filters_Body" TextLabelID="lbl_Filters_Header" Collapsed="True">
            </ajaxToolkit:CollapsiblePanelExtender>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
