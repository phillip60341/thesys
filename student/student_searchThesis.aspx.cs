using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class student_student_searchThesis : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DisplayThesis();
    }

    public void DisplayThesis()
    {
        ThesysController.PopulateGridView(gvThesis, "SELECT * FROM tblThesis");
    }

    protected void ddlView_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;

        if (ddl.SelectedValue == "1")
        {
            string ddlValue = ddlView.SelectedItem.ToString();
            ThesysController.PopulateGridView(gvThesis, "SELECT * FROM tblThesis where title like('% " + ddlValue + " %')");
        }
    }
}