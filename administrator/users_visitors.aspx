<%@ Page Title="" Language="C#" MasterPageFile="~/administrator/admin.master" AutoEventWireup="true" CodeFile="users_visitors.aspx.cs" Inherits="administrator_users_visitors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<%--TODO NEXT:
CRUD FOR Visitor--%>

<section class="content-header">
    <h1>
    Users
    <small>Visitors</small>
    </h1>
    <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li class="active">Users (Visitors)</li>
    </ol>

    <%--MODAL--%>
    <div class="modal fade" id="modal_addVisitor" role="dialog">
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
                    <asp:Button ID="btnAddVisitor" runat="server" Text="Add Visitor" CssClass="btn btn-success" OnClick="btnAddVisitor_Click"/>
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
                            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#modal_addVisitor">Add Visitor</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</section>

<div class="box-body">

    <asp:GridView ID="gvActiveVisitors" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered"
        OnRowEditing="gvActiveVisitors_RowEditing" OnRowCancelingEdit="gvActiveVisitors_RowCancelingEdit" OnRowDeleting="gvActiveVisitors_RowDeleting" OnRowUpdating="gvActiveVisitors_RowUpdating">
        <EmptyDataTemplate>
            <div class="text-center">
                Nothing to Display
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField HeaderText="Last Name">
                <ItemTemplate>
                    <asp:HiddenField ID="hdnVisitorID" runat="server" Value='<%# Eval("id") %>' />
                    <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("last_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HiddenField ID="e_hdnVisitorID" runat="server" Value='<%# Eval("id") %>' />
                    <asp:TextBox ID="e_txtLastName" runat="server" CssClass="form-control" Text='<%# Eval("last_name") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="First Name">
                <ItemTemplate>
                    <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("first_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="e_txtFirstName" runat="server" CssClass="form-control" Text='<%# Eval("first_name") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Middle Name">
                <ItemTemplate>
                    <asp:Label ID="lblMiddleName" runat="server" Text='<%# Eval("middle_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="e_txtMiddleName" runat="server"  CssClass="form-control" Text='<%# Eval("middle_name") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Expiry Date">
                <ItemTemplate>
                    <asp:Label ID="lblExpiryDate" runat="server" Text='<%# Eval("expiry_date") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="e_lblExpiryDate" runat="server" Text='<%# Eval("expiry_date") %>'></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-sm btn-warning" Text="Edit" CommandName="Edit"/>
                    <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-sm btn-danger" Text="Deactivate" CommandName="Delete" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-sm btn-success" Text="Save" CommandName="Update" />
                    <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-sm btn-danger" Text="Cancel" CommandName="Cancel" />
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:GridView ID="gvInactiveVisitors" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered" OnRowUpdating="gvInactiveVisitors_RowUpdating">
        <EmptyDataTemplate>
            <div class="text-center">
                Nothing to Display
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField HeaderText="Last Name">
                <ItemTemplate>
                    <asp:HiddenField ID="hdnVisitorID" runat="server" Value='<%# Eval("id") %>' />
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
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnActivate" runat="server" CssClass="btn btn-sm btn-success" Text="Activate" CommandName="Update"/>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>
</asp:Content>