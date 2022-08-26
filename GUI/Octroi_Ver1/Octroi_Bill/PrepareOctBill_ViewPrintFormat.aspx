<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrepareOctBill_ViewPrintFormat.aspx.cs" Inherits="GUI_Octroi_Ver1_Octroi_Bill_PrepareOctBill_ViewPrintFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
         var printyn="<%=printyn%>"
         if(printyn=="1")
         {
		  	window.print();
	     }
    </script>

    <style type="text/css">
        .blackfntS
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
        }
        .blackfnt
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
        }
        .leftrightborder
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
            border-left: solid 1px;
            border-right: solid 1px;
        }
        .leftbottomborder
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
            border-bottom: solid 1px;
            border-left: solid 1px;
        }
        .bottomrightborder
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
            border-bottom: solid 1px;
            border-right: solid 1px;
        }
        .leftborder
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
            border-left: solid 1px;
        }
         .rightborder
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
            border-right: solid 1px;
        }
        .bottomborder
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
            border-bottom: solid 1px;
        }
        .Topborder
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
            border-top: solid 1px;
        }
        .TopRightborder
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
            border-top: solid 1px;
            border-right:solid 1px;
        }
        .TopBottomBorder
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
            border-bottom: solid 1px;
            border-top: solid 1px;
        }
        .TopBottomRightBorder
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
            border-bottom: solid 1px;
            border-top: solid 1px;
            border-right: solid 1px;
        }
        .TopBottomRightLeftBorder
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
            border-bottom: solid 1px;
            border-top: solid 1px;
            border-right: solid 1px;
        }
        .LeftNoneTopBorder
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
            border-top: solid 1px;
            border-left: solid 0px;
        }
        .LeftRightTopBorder
        {
            font-weight: 500;
            font-size: 13px;
            line-height: 16px;
            font-family: Book Antiqua;
            border-left: solid 1px;
            border-right: solid 1px;
            border-top: solid 1px;
            border-bottom: solid 0px;
        }
        .NoneBorder
        {
            border: none;
        }
    </style>
</head>
<body>
    <%--<body>--%>
    <form id="form1" runat="server">
    <asp:Repeater ID="reptMain" runat="server" OnItemDataBound="reptMain_ItemDataBound">
        <ItemTemplate>
            <br />
            <table bgcolor="white" border="0" cellpadding="0" cellspacing="0" class="headerTbl"
                style="border-color: Black; height: 11.00in; width: 7.8in;">
                <tr>
                    <td valign="top" style="width: 100%;">
                        <%-- ADDRESS --%>
                        <table bgcolor="white" border="1" style="border-color: Black; width: 100%;" id="tblLogo"
                            runat="server" cellpadding="0" cellspacing="0" class="LeftRightTopBorder">
                            <tr>
                                <td align="center" style="height: 100%; width: 75%">
                                    <table border="0" cellpadding="0" cellspacing="0" class="bgwhite" style="height: 100%;
                                        width: 100%">
                                        <tr class="blackfnt" style="height: 20%">
                                            <td align="right" valign="top" colspan="3">
                                                <asp:Label ID="lblTitle1" CssClass="blackfnt" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="blackfnt" style="height: 22%">
                                            <td align="left" valign="top">
                                                <asp:Label ID="lblTitle" Font-Names="Book Antiqua" Font-Bold="true" Font-Size="18px"
                                                    Text="FUTURE LOGISTIC SOLUTIONS LIMITED" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr style="height: 15px">
                                            <td align="left" valign="middle">
                                                <asp:Label ID="Label1" CssClass="blackfnt" Text="5A - Shyam Nagar, Off Jogeshwari Vikhroli Link Road,"
                                                    Font-Bold="false" runat="server"></asp:Label>
                                            </td>
                                            <td rowspan="3" align="right">
                                                <img id="logo" style="height: 60px; width: 150px" alt="FutureLogo" src="../../images/Future_Group.jpg"/>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr style="height: 15px">
                                            <td align="left" valign="top">
                                                <asp:Label ID="Label3" CssClass="blackfnt" Text="Jogeshwari (East), Mumbai 400060"
                                                    Font-Bold="false" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr style="height: 15px">
                                            <td align="left" valign="top">
                                                <asp:Label ID="Label5" CssClass="blackfnt" Text="Tel No. 39569700 : Fax No. 39569701"
                                                    Font-Bold="false" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr style="height: 25px">
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr class="blackfnt" style="height: 20%">
                                            <td align="Center" valign="top" colspan="2">
                                                <asp:Label ID="Label4" Font-Names="Book Antiqua" Font-Bold="true" Font-Size="18px"
                                                    Text="INVOICE" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <%-- INVOICE --%>
                        <table bgcolor="white" border="1" rules="cols" cellpadding="0" cellspacing="0" style="border-color: Black;
                            height: 100%; width: 100%">
                            <tr class="blackfnt" style="height: 20px">
                                <td  style="border-color: White" align="center">
                                </td>
                                <td style="border-color: White" align="left">
                                </td>
                                <td style="border-color: White" align="center">
                                </td>
                                <td style="border-color: White" align="center">
                                </td>
                                <td style="border-color: White" align="center">
                                </td>
                                <td class="rightborder" align="center">
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 8%">
                                <%--  <td class="blackfnt" align="right" style="width: 50px" rowspan="4">
                                    <b>To,</b>
                                </td>--%>
                                <td class="blackfntS" style="border-color: White; padding-left: 5px; width: 500px"
                                    align="left" rowspan="4" colspan="2">
                                    <asp:Label ID="lblConsgnName" CssClass="blackfntS" Font-Bold="true" runat="server"></asp:Label>
                                    <br />
                                    <asp:Label ID="lblConsgnAdd" CssClass="blackfntS" Font-Bold="true" runat="server"></asp:Label>
                                </td>
                                <%--<td align="right" style="border-color:White;" colspan="2">
                                    <b>Invoice No. :</b>
                                </td>--%>
                                <td class="rightborder" align="left" colspan="4">
                                    <b>
                                        <asp:Label ID="lblInvoiceNo" CssClass="blackfntS" Font-Bold="true" runat="server"></asp:Label></b>
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <%--<td style="border-color:White;" align="right" colspan="2">
                                    <b>Invoice Date :</b>
                                </td>--%>
                                <td class="rightborder" align="left" colspan="4">
                                    <b>
                                        <asp:Label ID="lblInvoiceDate" CssClass="blackfntS" Font-Bold="true" runat="server"></asp:Label></b>
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="border-color: White; height: 20px">
                                <%--<td style="border-color: White;" align="left" colspan="2">
                                    <b>Month of :</b>
                                </td>--%>
                                <td class="rightborder" align="left" colspan="4">
                                    <b>
                                        <asp:Label ID="lblMonthof" CssClass="blackfntS" Font-Bold="true" runat="server"></asp:Label></b>
                                </td>
                            </tr>
                            <tr class="blackfnt" style="height: 20px">
                                <td style="border-color: White;" align="center">
                                </td>
                                <td style="border-color: White;" align="center">
                                </td>
                                <td style="border-color: White;" align="left">
                                </td>
                                <td style="border-color: White;" align="center" colspan="2">
                                </td>
                            </tr>                         
                            <tr class="blackfnt" valign="top" style="height: 20px; background-color: #c0c0c0">
                                <td class="TopBottomRightBorder" align="center">
                                    <b>Sr.No.</b>
                                </td>
                                <td class="TopBottomRightBorder" style="padding-left: 5px; width: 500px" align="left">
                                    <b>Particular</b>
                                </td>
                                <td class="TopBottomRightBorder" align="center" style="width: 80px">
                                    <b>Rs.</b>
                                </td>
                                <td class="TopBottomRightBorder" align="center" style="width: 100px">
                                    <b>Unit</b>
                                </td>
                                <td class="TopBottomRightBorder" align="center" style="width: 80px">
                                    <b>Rate(Rs)</b>
                                </td>
                                <td class="TopBottomRightBorder" align="center" style="width: 100px">
                                    <b>Amount(Rs)</b>
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                    1
                                </td>
                                <td class="leftrightborder" align="left">
                                    OCTROI REIMBURSMENT 
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="right">                                    
                                </td>
                                <td class="leftrightborder" align="center">                                
                                    <asp:Label ID="lblOctTotal" CssClass="blackfnt" runat="server"></asp:Label>
                                </td>                                
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">
                                    As Per Attached Annexure
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">
                                    SERVICE CHARGES @ 4%
                                </td>
                                <td class="leftrightborder" align="center">                                    
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                    <asp:Label ID="lblServiceCharge" CssClass="blackfnt" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">                                    
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">                                    
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">                                    
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">                                    
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">                                    
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">                                   
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">
                                    Total
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="TopBottomRightLeftBorder" align="center">
                                    <asp:Label ID="lblSubTotal" CssClass="blackfnt" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 2px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">                                   
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="bottomrightborder" align="center">                                    
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">                                    
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">                                    
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">
                                    <asp:Label ID="lblAdd" CssClass="blackfnt" Text="Add :" Font-Underline="true" runat="server"></asp:Label>
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="right">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">                                    
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">                                    
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">
                                    Service Tax @ 10 % on Service Charges
                                </td>
                                <td class="leftrightborder" align="center">
                                    <asp:Label ID="lblAmtStax" CssClass="blackfnt" runat="server"></asp:Label>
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                    <asp:Label ID="lblStax" CssClass="blackfnt" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">                                    
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">                                    
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">
                                    Education Cess @ 2 %
                                </td>
                                <td class="leftrightborder" align="center">                                    
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="right">
                                </td>
                                <td class="leftrightborder" align="center">
                                    <asp:Label ID="lblCess" CssClass="blackfnt" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">                                    
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">                                    
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">
                                    Secondary & Higher Education Cess @ 1%
                                </td>
                                <td class="leftrightborder" align="center">                                    
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                    <asp:Label ID="lblHcess" CssClass="blackfnt" runat="server"></asp:Label>
                                </td>
                            </tr>                            
                            <tr class="leftrightborder" valign="top" style="height: 100px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">                                   
                                </td>
                                <td class="leftrightborder" align="right">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="right">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                            </tr>
                            <tr class="leftrightborder" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="left">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="leftrightborder" align="right">
                                </td>
                                <td class="leftrightborder" align="center">
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="TopBottomRightLeftBorder" align="left">
                                    <b>Total </b>
                                </td>
                                <td class="TopBottomRightLeftBorder" align="center">
                                </td>
                                <td class="TopBottomRightLeftBorder" align="center">
                                </td>
                                <td class="TopBottomRightLeftBorder" align="center">
                                </td>
                                <td class="TopBottomRightLeftBorder" align="center">
                                    <asp:Label ID="lblTotal" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 2px">
                                <td class="leftrightborder" align="center">
                                </td>
                                <td class="TopBottomRightLeftBorder" align="left">                                    
                                </td>
                                <td class="TopBottomRightLeftBorder" align="center">
                                </td>
                                <td class="TopBottomRightLeftBorder" align="center">
                                </td>
                                <td class="TopBottomRightLeftBorder" align="center">
                                </td>
                                <td class="TopBottomRightLeftBorder" align="center">                                    
                                </td>
                            </tr>
                           <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="TopBottomBorder" align="center">
                                </td>
                                <td class="TopBottomRightBorder" align="left" colspan="5">
                                    <asp:Label ID="lblAmtInWord" CssClass="blackfnt" runat="server"></asp:Label>
                                </td>                               
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="Topborder" align="center" colspan="7">
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td colspan="7" class="rightborder">
                                    <table bgcolor="white" border="0" cellpadding="0" cellspacing="0" style="height: 100%;
                                        width: 100%">
                                        <tr class="blackfnt">
                                            <td class="blackfnt" style="width: 54%" align="left" colspan="2">
                                                PAN No : AAACF9650N
                                                <%--<asp:Label ID="lblPANNo" CssClass="blackfnt" runat="server"></asp:Label> --%>
                                            </td>
                                            <td style="border: none; padding-right: 75px" align="right" colspan="3">
                                                For <b>Future Logistic Solutions Ltd.</b>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="rightborder" align="left" colspan="6">
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="rightborder" align="left" colspan="6">
                                    Service Tax No : AAACF9650NST001                                    
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="rightborder" align="left" colspan="6">
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="rightborder" align="left" colspan="6">
                                    Service Tax Category : Goods Transport Agency
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="rightborder" align="center" colspan="6">
                                    <table bgcolor="white" border="0" cellpadding="0" cellspacing="0" style="height: 100%;
                                        width: 100%">
                                        <tr class="blackfnt">
                                            <td class="blackfnt" style="width: 65%" align="left" colspan="2">
                                            </td>
                                            <td class="blackfnt" align="left" colspan="3">
                                                Authorised Signatory
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <%--<td class="LeftNoneTopBorder" align="center" colspan="3">
                                Authorised Signatory
                            </td>--%>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="rightborder" align="left" colspan="6">
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="rightborder" align="left" colspan="6">
                                    <b>E & O.E. </b>
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="rightborder" align="center" colspan="6">
                                </td>
                            </tr>
                            <tr class="blackfnt" valign="top" style="height: 20px">
                                <td class="rightborder" align="center" colspan="6">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div id="dvPage" runat="server">
            </div>
        </ItemTemplate>
    </asp:Repeater>
    </form>
</body>
</html>
