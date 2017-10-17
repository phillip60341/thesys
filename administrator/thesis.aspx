<%@ Page Title="" Language="C#" MasterPageFile="~/administrator/admin.master" AutoEventWireup="true" CodeFile="thesis.aspx.cs" Inherits="administrator_thesis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<section class="content-header">
    <h1>
    Thesis
    <small><asp:Label ID="lblThesisType" runat="server"></asp:Label></small>
    </h1>
    <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li class="active">Thesis</li>
    </ol>
</section>

<div class="box-body">
    <table class="table table-bordered">
    <tr>
        <th>Title</th>
        <th>Category</th>
        <th>Type</th>
        <th>Proponents</th>
        <th>Evaluators</th>
        <th>Actions</th>
    </tr>
    <tr>
        <td>SampleTitle</td>
        <td>SampleCategory</td>
        <td>SampleType</td>
        <td>SampleProponents</td>
        <td>SampleEvaluators</td>
        <td>
            <button type="button" class="btn btn-sm btn-danger">Delete</button>
            <button type="button" class="btn btn-sm btn-warning">Edit</button>
        </td>
    </tr>
    
    </table>
</div>

</asp:Content>