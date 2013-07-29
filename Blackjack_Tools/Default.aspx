<%@ Page Title="Home Page - Blackjack Tools" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="Blackjack_Tools._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:Panel ID="pnl_PermissionsIssue" runat="server" ForeColor="Red" 
        Visible="False">
        Oh, hello there.
        <br />
        It looks like you&#39;ve either just registered, or your permissions haven&#39;t been 
        set up yet. Please give me a nudge on the forums and I&#39;ll get your access set 
        up.</asp:Panel>
    <h2>
        Welcome to blackjack tools
        <asp:Label ID="lbl_UserName" runat="server" Font-Bold="True"></asp:Label>
    </h2>
    <p>
        If you got here from the Blackjack forums, you&#39;ve probably got an excellent idea 
        <ajaxToolkit:ToolkitScriptManager ID="TSM_Default" runat="server">
        </ajaxToolkit:ToolkitScriptManager>
        of how to use this database.<br />
        If you&#39;ve no clue how to use the database, please go back and read the 
        instructions.
    </p>
    <asp:Panel ID="pnl_PatchNotes" runat="server">
        <asp:Label ID="lbl_PatchNotesHeader" runat="server" Text="Change Log" 
            Font-Bold="True" Font-Size="Large"></asp:Label>
        <ajaxToolkit:Accordion ID="acc_Patchnotes" runat="server" 
            FadeTransitions="True" RequireOpenedPane="False" Width="80%">
            <Panes>
                <ajaxToolkit:AccordionPane ID="PaneFive" runat="server">
                <Header>
                    <asp:Label ID="lbl_FifthHeader" Width="100%" runat="server" BackColor="Silver" Font-Bold="true" Font-Size="Medium" Text="Version 0.7.2 - 07/25/13"></asp:Label>
                </Header>
                <Content>
                    <asp:Label ID="lbl_FifthChanges" runat="server" Font-Bold="true" Text="Changes"></asp:Label>
                    <asp:BulletedList ID="bul_FifthChanges" runat="server">
                        <asp:ListItem>Admin: Ordered item management tables by name of item
                        </asp:ListItem>
                        <asp:ListItem>Admin: Fixed the collapsible panel to fit the user management gridview
                        </asp:ListItem>
                        <asp:ListItem>Changed all User permissions to be loaded from the session variable they were supposed to be loaded from
                        </asp:ListItem>
                        <asp:ListItem>Requester_ID is now actually an ID field (this was way harder than it sounds)
                        </asp:ListItem>
                        <asp:ListItem>Introducing User Flair with really low standards. 3 verified jobs means you get a bronze spade, 6 means you get a silver spade.
                        </asp:ListItem>
                    </asp:BulletedList>
                </Content>
                </ajaxToolkit:AccordionPane>
                <ajaxToolkit:AccordionPane ID="PaneFour" runat="server">
                    <Header>
                        <asp:Label ID="lbl_FourthHeader" Width="100%" runat="server" BackColor="Silver" Font-Bold="true" Font-Size="Medium" Text="Version 0.7.1 - 07/24/13"></asp:Label>
                    </Header>
                    <Content>
                        <asp:Label ID="lbl_FourthChanges" runat="server" Font-Bold="true" Text="Changes"></asp:Label>
                        <asp:BulletedList ID="bul_FourthChanges" runat="server">
                            <asp:ListItem>User page looks a bit better now. Gridviews will no longer oscillate wildly in width.
                            </asp:ListItem>
                            <asp:ListItem>Replaced the FulfilledBy field with a boolean field "Fulfilled", and modified the program to accommodate.
                            </asp:ListItem>
                            <asp:ListItem>Admins can now do the following things:
                            </asp:ListItem>
                            <asp:ListItem>Unlock users who have accidentally locked themselves out of their accounts due to password issues
                            </asp:ListItem>
                            <asp:ListItem>Leave comments on users
                            </asp:ListItem>
                            <asp:ListItem>Far more easily view, add, and remove users from roles
                            </asp:ListItem>
                            <asp:ListItem>Do light item database management (of the dropdowns on the crafting and gathering pages)
                            </asp:ListItem>
                        </asp:BulletedList>
                    </Content>
                </ajaxToolkit:AccordionPane>
                <ajaxToolkit:AccordionPane ID="acp_ThirdRecord" runat="server">
                    <Header>
                        <asp:Label ID="lbl_ThirdHeader" Width="100%" runat="server" BackColor="Silver" Font-Bold="true" Font-Size="Medium" Text="Version 0.7 - 07/23/13"></asp:Label>
                    </Header>
                    <Content>
                        <asp:Label ID="lbl_ThirdChanges" runat="server" Font-Bold="true" Text="Changes"></asp:Label>
                        <asp:BulletedList ID="bul_ThirdChanges" runat="server">
                            <asp:ListItem>All user names contained on the sites now link to the user page of their respective owner.
                            </asp:ListItem>
                            <asp:ListItem>Rewards have been implemented, current currencies accepted are gil and shards
                            </asp:ListItem>
                            <asp:ListItem>XIVDB tooltips integrated! HUZZAH!!!
                            </asp:ListItem>
                            <asp:ListItem>Panels on the User page now adjust to the height of the gridview controls it contains.
                            </asp:ListItem>
                            <asp:ListItem>New feature: What you're reading right now!
                            </asp:ListItem>
                        </asp:BulletedList>
                        <asp:Label ID="lbl_ThirdBugs" runat="server" Text="Bugs Introduced"></asp:Label>
                        <asp:BulletedList ID="bul_ThirdBugs" runat="server">
                        <asp:ListItem>All tooltips currently break if you change a gridview's displayed page. (Not sure what's
                            going on here.)
                        </asp:ListItem>
                        </asp:BulletedList>
                    </Content>
                </ajaxToolkit:AccordionPane>
                <ajaxToolkit:AccordionPane ID="acp_SecondRecord" runat="server">
                <Header>
                    <asp:Label ID="lbl_SecondHeader" Width="100%" runat="server" BackColor="Silver" Font-Bold="true" Font-Size="Medium" Text="Version 0.6.9 - 07/22/13"></asp:Label>
                </Header>
                <Content>
                    <asp:Label ID="lbl_SecondChanges" runat="server" Font-Bold="true" Text="Changes"></asp:Label>
                    <asp:BulletedList ID="bul_SecondChanges" runat="server">
                        <asp:ListItem>Collapsible panels no longer collapse if your last action was taken inside that panel
                        </asp:ListItem>
                        <asp:ListItem>Implemented Tighter Item Entry control. All items are selected from dropdowns to 
                           minimize chance of sql injection.
                        </asp:ListItem>
                        <asp:ListItem>All item names will now (hopefully) be hyperlinked to xivdb. This should be expected to
                            change to having the tooltips implemented (hopefully) within the next week.
                        </asp:ListItem>
                        <asp:ListItem>Made some changes to the way pages consider roles. Unassigned users have no more access
                            than before, but are now told to contact me regarding permissions.
                        </asp:ListItem>
                    </asp:BulletedList>
                </Content>
                </ajaxToolkit:AccordionPane>
                <ajaxToolkit:AccordionPane ID="acp_FirstRecord" runat="server">
                <Header>
                    <asp:Label ID="lbl_FirstHeader" Width="100%" BackColor="Silver" runat="server" Font-Bold="True" Font-Size="Medium"
                         Text="Version 0.6.8 - 07/22/13"></asp:Label>
                </Header>
                <Content>
                    <asp:Label ID="lbl_FirstChanges" runat="server" Font-Bold="true" Text="Changes"></asp:Label>
                    <asp:BulletedList ID="bul_FirstChanges" runat="server">
                        <asp:ListItem>Old text commands are gone, and are now replaced by image buttons that
                             dynamically populate in rows based on what options you have available.
                        </asp:ListItem>
                        <asp:ListItem>Dates were moved from popups to tooltips. You no longer have to click on the information icon
                            to make it display (on the user page)
                        </asp:ListItem>
                        <asp:ListItem>The information icon now only displays if the respective record would actually have information
                            for it to display.
                        </asp:ListItem>
                        <asp:ListItem>User page now has record verification as well as the functions related to it.
                        </asp:ListItem>
                        <asp:ListItem>The crafting side of the database can now have an amount specified. This will help in orders
                            for potions, materia, and raw goods.
                        </asp:ListItem>
                    </asp:BulletedList>
                     <asp:Label ID="lbl_FirstBugFixes" runat="server"  Font-Bold="true" Text="Bug Fixes"></asp:Label>
                    <asp:BulletedList ID="bul_FirstBugFixes" runat="server">
                    <asp:ListItem>The menu system. 'Nuff said.
                    </asp:ListItem>
                    </asp:BulletedList>
                </Content>
                </ajaxToolkit:AccordionPane>
            </Panes>
        </ajaxToolkit:Accordion>
    </asp:Panel>
    </form>
    <asp:Panel ID="pnl_Donate" runat="server">
        <p>Please consider donating to the site. Donations keeps the site up and going and gives us the ability to expand with new features!</p>
        <form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_blank">
        <input type="hidden" name="cmd" value="_s-xclick" />
        <input type="hidden" name="hosted_button_id" value="RK7SK2Z5ETUMJ" />
        <input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donate_SM.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!" />
        <img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1" />
        </form>
    </asp:Panel>
</asp:Content>
