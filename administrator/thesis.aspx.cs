using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class administrator_thesis : System.Web.UI.Page
{

    int status = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           /* string typeOfThesis = "";
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
                    break; */
        }

            DisplayThesis();
    }

    protected void gvThesis_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView gv = sender as GridView;

        gv.EditIndex = e.NewEditIndex;

        DisplayThesis();
    }

    public void DisplayThesis()
    {
        ThesysController.PopulateGridView(gvThesis, "SELECT * FROM tblThesis");
    }

    protected void btnAddThesis_Click(object sender, EventArgs e)
    {
        string thesis_id, title, thesis_file;

        thesis_id = add_txtThesisID.Text.ToString();
        title = add_txtThesisTitle.Text.ToString();
        thesis_file = add_txtThesisFile.Text.ToString();

        string addQuery = "INSERT INTO tblThesis(thesis_id, title, thesis_file) VALUES(@thesis_id, @title, @thesis_file)";
        string[] addParameters = { "@thesis_id", "@title", "@thesis_file" };
        string[] addValues = { thesis_id, title, thesis_file };

        ThesysController.QueryExecuteWithParameters(addQuery, addParameters, addValues);

        Response.Redirect("dashboard.aspx");
    }

    protected void ddlView_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;

        if (ddl.SelectedValue == "1")
        {
            Response.Redirect("thesis.aspx?mode=archived");
        }
        else
        {
            Response.Redirect("thesis.aspx?mode=active");
        }
    }

    protected void gvThesis_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView gv = (GridView)sender;

        gv.EditIndex = -1;

        DisplayThesis();
    }

    protected void gvThesis_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gv = (GridView)sender;

        HiddenField e_hdnThesisID = (HiddenField)gv.Rows[e.RowIndex].FindControl("e_hdnThesisID");
        TextBox e_txtThesisTitle = (TextBox)gv.Rows[e.RowIndex].FindControl("e_txtThesisTitle");
        TextBox e_txtThesisFile = (TextBox)gv.Rows[e.RowIndex].FindControl("_txtThesisFile");

        string thesis_id, thesis_title, thesis_file;

        thesis_id = e_hdnThesisID.Value.ToString();
        thesis_title = e_txtThesisTitle.Text.ToString();
        thesis_file = e_txtThesisFile.Text.ToString();

        string query = "UPDATE tblUsers SET thesis_id=@thesis_id,thesis_title=@thesis_title, WHERE thesis_id=@thesis_id";
        string[] updateparameters = { "@thesis_id", "@thesis_title", "@thesis_file" };
        string[] updatevalues = { thesis_id, thesis_title, thesis_file };

        ThesysController.QueryExecuteWithParameters(query, updateparameters, updatevalues);

        Response.Redirect("users_thesis.aspx?mode=active");
    }

    protected void gvThesis_RowArchiving(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = sender as GridView;

        HiddenField hdnThesisID = (HiddenField)gv.Rows[e.RowIndex].FindControl("hdnThesisID");

        string user_id = hdnThesisID.Value.ToString();

        string query = "UPDATE tblThesis SET status=archived WHERE thesis_id=" + user_id;
        ThesysController.QueryExecuteWithParameters(query, new string[0], new string[0]);
        DisplayThesis();
    }
}
