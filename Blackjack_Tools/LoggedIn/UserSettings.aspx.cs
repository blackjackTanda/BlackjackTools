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

        protected void grdv_Filters_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
        }

        protected void frmv_Settings_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }
    }
}
