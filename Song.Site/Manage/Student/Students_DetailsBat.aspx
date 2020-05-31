﻿<%@ Page Language="C#" MasterPageFile="~/Manage/PageWin.Master" AutoEventWireup="true"
    CodeBehind="Students_DetailsBat.aspx.cs" Inherits="Song.Site.Manage.Student.Students_DetailsBat"
    Title="学员信息详情" %>

<%@ MasterType VirtualPath="~/Manage/PageWin.Master" %>
<%@ Register Assembly="WeiSha.WebControl" Namespace="WeiSha.WebControl" TagPrefix="cc1" %>
<%@ Register Assembly="WeiSha.WebEditor" Namespace="WeiSha.WebEditor" TagPrefix="WebEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphMain" runat="server">
    <script type="text/javascript" src="/Utility/CoreScripts/jquery.qrcode.min.js"></script>
    <script type="text/javascript" src="/Manage/CoreScripts/jquery.jqprint-0.3.js"></script>
    <img id="stamp" />
    <div id="app-area">
        <div>
            学员数量：{{students.length}}</div>
        <div>
            完成数：{{finishcount}}</div>
        <div>
            状态：{{loading}}</div>
            {{students.length}}
          
        <div class="page"  v-for="d in students">
            <div class="page-title">
                学习证明</div>
            <table width="100%" class="first" border="1" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="right" width="120px">
                        姓名：
                    </td>
                    <td class="left" width="100px">
                        {{d.Ac_Name}}
                    </td>
                    <td class="right" width="100px">
                        性别：
                    </td>
                    <td class="left">
                        {{d.Ac_Sex== 0 ? "未知" : (d.Ac_Sex== 1 ? "男" : "女")}}
                    </td>
                    <td rowspan="5" valign="middle" class="photo">
                  
                        <img :src='d.Ac_Photo' 
                                width="150px" height="200px" onerror="this.style.setProperty('display','none')" />
                    </td>
                </tr>
                <tr>
                    <td class="right">
                        年龄：
                    </td>
                    <td class="left">                    
                        {{d.Ac_Age > 200 || d.Ac_Age<=0 ? "" : d.Ac_Age}}
                    </td>
                    <td class="right">
                        出生年月：
                    </td>
                    <td class="left">
                    {{birthday('yyyy年M月',d.Ac_Birthday)}}
                    </td>
                </tr>
                <tr>
                    <td class="right">
                        籍贯：
                    </td>
                    <td class="left">
                        {{d.Ac_Native}}
                    </td>
                    <td class="right">
                        学号：
                    </td>
                    <td class="left">
                        {{d.Ac_CodeNumber}}
                    </td>
                </tr>
                <tr>
                    <td class="right">
                        民 族：
                    </td>
                    <td class="left">
                        {{d.Ac_Nation}}
                    </td>
                    <td class="right">
                        身份证：
                    </td>
                    <td class="left">
                        <span class="txtrow">
                            {{d.Ac_IDCardNumber}}</span>
                    </td>
                </tr>
                <tr>
                    <td class="right">
                        学历：
                    </td>
                    <td class="left">
                        {{getedu(d.Ac_Education)}}
                    </td>
                    <td class="right">
                        专业：
                    </td>
                    <td class="left">
                        {{d.Ac_Major}}
                    </td>
                </tr>
            </table>
         
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBtn" runat="server">
    <input type="button" name="btnPrint" value="打印" id="btnPrint" />
</asp:Content>
