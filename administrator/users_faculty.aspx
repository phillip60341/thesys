<%@ Page Title="" Language="C#" MasterPageFile="~/administrator/admin.master" AutoEventWireup="true" CodeFile="users_faculty.aspx.cs" Inherits="administrator_users_faculty" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<section class="content-header">
    <h1>
    Users
    <small>Faculty</small>
    </h1>
    <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li class="active">Users (Faculty)</li>
    </ol>
    <br />

    <%--MODAL--%>
    <div class="modal fade" id="modal_addFaculty" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    Add a Faculty
                </div>
                <div class="modal-body box-body">
                    <table class="table">
                        <tr>
                            <td>College</td>
                            <td>
                                <asp:DropDownList ID="add_ddlCollege" runat="server" CssClass="form-control"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>First Name:</td>
                            <td>
                                <asp:TextBox ID="add_txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="add_txtFirstName" SetFocusOnError="true" ErrorMessage="This field is required" Font-Size="X-Small" ForeColor="Red"/>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>Middle Name:</td>
                            <td>
                                <asp:TextBox ID="add_txtMiddleName" runat="server" CssClass="form-control"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="add_txtMiddleName" SetFocusOnError="true" ErrorMessage="This field is required" Font-Size="X-Small" ForeColor="Red"/>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>Last Name:</td>
                            <td>
                                <asp:TextBox ID="add_txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="add_txtLastName" SetFocusOnError="true" ErrorMessage="This field is required" Font-Size="X-Small" ForeColor="Red"/>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>User name:</td>
                            <td>
                                <asp:TextBox ID="add_txtUserName" runat="server" CssClass="form-control"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="add_txtUserName" SetFocusOnError="true" ErrorMessage="This field is required" Font-Size="X-Small" ForeColor="Red"/>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>Password</td>
                            <td>
                                <asp:TextBox ID="add_txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="add_txtPassword" SetFocusOnError="true" ErrorMessage="This field is required" Font-Size="X-Small" ForeColor="Red"/>--%>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnAddFaculty" runat="server" Text="Add Faculty" CssClass="btn btn-sm btn-success" OnClick="btnAddFaculty_Click" />
                </div>
            </div>
        </div>
    </div>
    <%--END MODAL--%>

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
                            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#modal_addFaculty">Add Faculty</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</section>

<div class="box-body">

    <asp:GridView ID="gvActiveFaculties" runat="server" CssClass="table table-bordered" AutoGenerateColumns="false"
        OnRowEditing="gvActiveFaculties_RowEditing"
        OnRowCancelingEdit="gvActiveFaculties_RowCancelingEdit"
        OnRowDataBound="gvActiveFaculties_RowDataBound"
        OnRowDeleting="gvActiveFaculties_RowDeleting" OnRowUpdating="gvActiveFaculties_RowUpdating">
        <EmptyDataTemplate>
            <div class="text-center">
                Nothing to Display
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField HeaderText="Last Name">
                <ItemTemplate>
                    <asp:HiddenField ID="hdnFacultyID" runat="server" Value='<%# Eval("id") %>' />
                    <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("last_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HiddenField ID="e_hdnFacultyID" runat="server" Value='<%# Eval("id") %>' />
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
                    <asp:Label ID="lblDepartment" runat="server" Text='<%# Eval("college_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HiddenField ID="e_hdnCollegeID" runat="server" Value='<%# Eval("college_id") %>' />
                    <asp:DropDownList ID="e_ddlCollege" runat="server" CssClass="form-control"></asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-sm btn-warning" Text="Edit" CommandName="Edit"/>
                    <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-sm btn-danger" Text="Delete" CommandName="Delete" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-sm btn-danger" Text="Cancel" CommandName="Cancel"/>
                    <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-sm btn-success" Text="Save" CommandName="Update" />
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:GridView ID="gvInactiveFaculties" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered" OnRowUpdating="gvInactiveFaculties_RowUpdating">
        <EmptyDataTemplate>
            <div class="text-center">
                Nothing to Display
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField HeaderText="Last Name">
                <ItemTemplate>
                    <asp:HiddenField ID="hdnFacultyID" runat="server" Value='<%# Eval("id") %>' />
                    <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("last_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="First Name">
                <ItemTemplate>
                    <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("first_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Middle Name">
                <ItemTemplate>
                    <asp:Label ID="lblMiddleName" runat="server" Text='<%# Eval("middle_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="College">
                <ItemTemplate>
                    <asp:Label ID="lblCollege" runat="server" Text='<%# Eval("college_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnActivate" runat="server" Text="Activate" CommandName="Update" CssClass="btn btn-sm btn-success"/>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>

</asp:Content>