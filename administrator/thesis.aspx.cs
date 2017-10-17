using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class administrator_thesis : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string typeOfThesis = "";
            typeOfThesis = Request.QueryString["type"];
            switch (typeOfThesis)
            {
                case "undergrad":
                    lblThesisType.Text = "Undergraduate";
                    break;

                case "masters":
                    lblThesisType.Text = "Masteral";
                    break;

                case "doctors":
                    lblThesisType.Text = "Doctorate";
                    break;

                default:
                    Response.Redirect("dashboard.aspx");
                    break;
            }
        }
    }
}