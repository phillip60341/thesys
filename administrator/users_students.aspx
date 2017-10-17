<%@ Page Title="" Language="C#" MasterPageFile="~/administrator/admin.master" AutoEventWireup="true" CodeFile="users_students.aspx.cs" Inherits="administrator_users_students" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<section class="content-header">
    <h1>
    Users
    <small>Students</small>
    </h1>
    <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li class="active">Users (Students)</li>
    </ol>
    <br />

    <%--MODAL--%>
    <div class="modal fade" id="modal_addStudent" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    Add a Student
                </div>
                <div class="modal-body">
                    <div class="box-body">
                        <table class="table table-bordered">
                            <tr>
                                <td>
                                    First Name:
                                </td>
                                <td>
                                    <asp:TextBox ID="add_txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Middle Name:
                                </td>
                                <td>
                                    <asp:TextBox ID="add_txtMiddleName" runat="server" CssClass="form-control"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Last Name:
                                </td>
                                <td>
                                    <asp:TextBox ID="add_txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    College
                                </td>
                                <td>
                                    <%--<asp:TextBox ID="add_txtCollege" runat="server" CssClass="form-control"></asp:TextBox>--%>
                                    <asp:DropDownList ID="add_ddlCollege" runat="server" CssClass="form-control"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Program
                                </td>
                                <td>
                                    <%--<asp:TextBox ID="add_txtProgram" runat="server" CssClass="form-control"></asp:TextBox>--%>
                                    <asp:DropDownList ID="add_ddlProgram" runat="server" CssClass="form-control"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    ID Number:
                                </td>
                                <td>
                                    <asp:TextBox ID="add_txtIDNumber" runat="server" CssClass="form-control"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    User Name:
                                </td>
                                <td>
                                    <asp:TextBox ID="add_txtUserName" runat="server" CssClass="form-control"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Password:
                                </td>
                                <td>
                                    <asp:TextBox ID="add_txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnAddStudent" runat="server" Text="Add Student" CssClass="btn btn-success" OnClick="btnAddStudent_Click"/>
                </div>
            </div>
        </div>
    </div>
    <%--END MODAL--%>
    <%--<div class="clearfix"></div>--%>

    <div class="row">
        <div class="col-lg-9">

        </div>
        <div class="col-lg-3 text-right">
            <div>
                <table style="width:100%;">
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlView" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlView_SelectedIndexChanged">
                                <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                                <asp:ListItem Value="0" Text="Inactive"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="text-right">
                            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#modal_addStudent">Add Student</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

</section>



<div class="box-body">

    <asp:GridView ID="gvActiveStudents" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered" 
        OnRowEditing="gvStudents_RowEditing"
        OnRowCancelingEdit="gvStudents_RowCancelingEdit"
        OnRowDeleting="gvStudents_RowDeleting"
        OnRowUpdating="gvStudents_RowUpdating"
        OnRowDataBound="gvStudents_RowDataBound"
        >
        <EmptyDataTemplate>
            <div class="text-center">
                Nothing to Display
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField HeaderText="ID Number">
                <ItemTemplate>
                    <asp:HiddenField ID="hdnStudentID" runat="server" Value='<%# Eval("student_id") %>' />
                    <asp:Label ID="lblIDNumber" runat="server" Text='<%# Eval("id_number") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HiddenField ID="e_hdnStudentID" runat="server" Value='<%# Eval("student_id") %>'/>
                    <asp:Textbox ID="txtIDNumber" runat="server" Text='<%# Eval("id_number") %>' Enabled="false" CssClass="form-control"></asp:Textbox>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Last Name">
                <ItemTemplate>
                    <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("last_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="e_txtLastName" runat="server" Text='<%# Eval("last_name") %>' CssClass="form-control"></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="First Name">
                <ItemTemplate>
                    <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("first_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="e_txtFirstName" runat="server" Text='<%# Eval("first_name") %>' CssClass="form-control"></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Middle Name">
                <ItemTemplate>
                    <asp:Label ID="lblMiddleName" runat="server" Text='<%# Eval("middle_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="e_txtMiddleName" runat="server" Text='<%# Eval("middle_name") %>' CssClass="form-control"></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="College">
                <ItemTemplate>
                    <asp:Label ID="lblCollege" runat="server" Text='<%# Eval("college_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HiddenField ID="e_hdnCollegeID" runat="server" Value='<%# Eval("college_id") %>' />
                    <asp:DropDownList ID="e_ddlCollege" runat="server" CssClass="form-control"></asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Program">
                <ItemTemplate>
                    <asp:Label ID="lblProgram" runat="server" Text='<%# Eval("program_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HiddenField ID="e_hdnProgramID" runat="server" Value='<%# Eval("program_id") %>' />
                    <asp:DropDownList ID="e_ddlProgram" runat="server" CssClass="form-control"></asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Expiry Date">
                <ItemTemplate>
                    <asp:Label ID="lblExpiryDate" runat="server" Text='<%# Eval("expiry_date","{0:MMMM dd, yyyy}") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="e_lblExpiryDate" runat="server" Text='<%# Eval("expiry_date","{0:MMMM dd, yyyy}") %>'></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-sm btn-warning" Text="Edit" CommandName="Edit"/>
                    <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-sm btn-danger" Text="Deactivate" CommandName="Delete" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-sm btn-success" Text="Save" CommandName="Update" />
                    <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-sm btn-danger" Text="Cancel" CommandName="Cancel"/>
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:GridView ID="gvInactiveStudents" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered"
        OnRowUpdating="gvInactiveStudents_RowUpdating">
        <EmptyDataTemplate>
            <div class="text-center">
                Nothing to Display
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField HeaderText="Last Name">
                <ItemTemplate>
                    <asp:HiddenField ID="hdnStudentID" runat="server" Value='<%# Eval("student_id") %>'/>
                    <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("last_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="First Name">
                <ItemTemplate>
                    <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("first_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Expired/Deactivated On">
                <ItemTemplate>
                    <asp:Label ID="lblExpiryDate" runat="server" Text='<%# Eval("expiry_date") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:Button ID="btnActivate" runat="server" Text="Activate" CssClass="btn btn-sm btn-success" CommandName="Update"/>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

<%--    <table class="table table-bordered">
    <tr>
        <th>ID Number</th>
        <th>Last Name</th>
        <th>First Name</th>
        <th>Middle Initial</th>
        <th>College</th>
        <th>Program</th>
        <th>Actions</th>
    </tr>

    <tr>
        <td>SampleIDNumber</td>
        <td>SampleLast</td>
        <td>SampleFirst</td>
        <td>Sample Middle</td>
        <td>Sample College</td>
        <td>Program</td>
        <td>
            <button type="button" class="btn btn-sm btn-danger">Delete</button>
            <button type="button" class="btn btn-sm btn-warning">Edit</button>
        </td>
    </tr>
    </table>--%>
</div>
</asp:Content>