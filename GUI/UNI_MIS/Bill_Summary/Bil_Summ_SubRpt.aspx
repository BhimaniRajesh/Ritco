<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="Bil_Summ_SubRpt.aspx.cs" Inherits="BillRegister_ShowBillDetails" %>

<%--<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
--%>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
        
        <script language="javascript" type="text/javascript">
            function OpenPopup(Bill_Number) 
                { 
                    //window.open("Bill_Summ_RptPopup.aspx?Bill_Number=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                    //window.open("BillNo_Popup.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                    client="<%=Session["Client"].ToString()%>"
                       if(client=="EXL")
                       {
                        window.open("../../Finance/Billing/BillViewPrint/BillNo_Popup_EXL.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                       }
                       else if(client=="RCI")
                       {
                        window.open("../../Finance/Billing/BillViewPrint/BillNo_Popup_RCI.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                       }
                       else if(client=="PRRL")
                       {
                        window.open("../../Finance/Billing/BillViewPrint/BillNo_Popup_PRRL.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                       }
                       else if(client=="UFL")
                       {
                        window.open("../../Finance/Billing/BillViewPrint/BillNo_Popup_UFL.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                       }
                       else
                       {
                        window.open("../../Finance/Billing/BillViewPrint/BillNo_Popup.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
                       }
                 }
                 
            function popupmenu2(strURL, BillNo, printYN)
            {
                var winOpts = "scrollbars=yes,resizable=yes,width=500,height=400";
                
                confirmWin = window.open(strURL + "?" + BillNo + "," + printYN, "", winOpts);
            }
            
            function PageSelectionChanged(objPages)
            {
                if(document.getElementById("HIDCurrentPageNo"))
                {
                    document.getElementById("HIDCurrentPageNo").value = objPages.value;
                    document.frmBillRegisterDetails.submit();
                }                    
            }
             
        </script>

    &nbsp;<a href="javascript:window.history.go(-1)" title="back"><img id="IMG1" align="right"
        alt="" border="0" src="../../../GUI/images/back.gif" /></a><br />
    &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_finance.aspx">Finance</asp:HyperLink>
    &gt;&nbsp;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Strikeout="False" Font-Underline="True"
        NavigateUrl="~/GUI/UNI_MIS/Bill_Summary/Query.aspx">Bill Summary</asp:HyperLink><br />
    &nbsp;<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                                        
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 39%" valign="top">
                                                            
                                                            <p align="center">
                                                                <label class="blackfnt">
                                                                    <b>
                                                                        You Selected
                                                                    </b>
                                                                </label>
                                                            </p>
                                                            <p>
                                                                <label class="blackfnt">
                                                                    <b>
                                                                        <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
                                                                            <tr style="background-color: #ffffff">
                                                                                <td style="width: 211px; height: 10px">
                                                                                    <label class="blackfnt">
                                                                                        Date</label></td>
                                                                                <td style="height: 10px">
                                                                                    <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                                                                                    - 
                                                                                    <asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                            </tr>
                                                                            <tr style="background-color: #ffffff">
                                                                                <td style="width: 211px; height: 15px">
                                                                                    <label class="blackfnt">
                                                                                        Ro</label></td>
                                                                                <td style="width: 343px; height: 15px">
                                                                                    <asp:Label ID="lblRo" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                            </tr>
                                                                            <tr style="background-color: #ffffff">
                                                                                <td style="width: 211px">
                                                                                    <label class="blackfnt">
                                                                                        Location</label></td>
                                                                                <td style="width: 343px">
                                                                                    <asp:Label ID="lblLoc" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                            </tr>
                                                                            <tr style="background-color: #ffffff">
                                                                                <td class="blackfnt" style="width: 211px">
                                                                                    Submission</td>
                                                                                <td style="width: 343px">
                                                                                    <asp:Label ID="lblSub" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                            </tr>
                                                                            <tr style="background-color: #ffffff">
                                                                                <td class="blackfnt" style="width: 211px">
                                                                                    Collection Location</td>
                                                                                <td style="width: 343px">
                                                                                    <asp:Label ID="lblCollLoc" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                            </tr>
                                                                            <tr style="background-color: #ffffff">
                                                                                <td class="blackfnt" style="width: 211px">
                                                                                    Customer Code</td>
                                                                                <td style="width: 343px">
                                                                                    <asp:Label ID="lblCustCode" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                            </tr>
                                                                            <tr style="background-color: #ffffff">
                                                                                <td class="blackfnt" style="width: 211px">
                                                                                    Bill Type</td>
                                                                                <td style="width: 343px">
                                                                                    <asp:Label ID="lblBillType" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                            </tr>
                                                                            <tr style="background-color: #ffffff">
                                                                                <td class="blackfnt" style="width: 211px">
                                                                                    Bill Amount</td>
                                                                                <td style="width: 343px">
                                                                                    <asp:Label ID="lblBillAmt" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                            </tr>
                                                                            <tr style="background-color: #ffffff">
                                                                                <td class="blackfnt" style="width: 211px">
                                                                                    Listing</td>
                                                                                <td style="width: 343px">
                                                                                    <asp:Label ID="lblList" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                            </tr>
                                                                            <tr style="background-color: #ffffff">
                                                                                <td class="blackfnt" style="width: 211px">
                                                                                    Report Date</td>
                                                                                <td style="width: 343px">
                                                                                    <asp:Label ID="lblRptDate" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                            </tr>
                                                                            <tr style="background-color: #ffffff">
                                                                                <td class="blackfnt" style="width: 211px">
                                                                                    Bill
                                                                                Status</td>
                                                                                <td style="width: 343px">
                                                                                    <asp:Label ID="lblBillStatus" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                            </tr>
                                                                        </table>
                                                                    </b>
                                                                </label>
                                                            </p>
                                                            
                                                            <%--<center>--%>
                                                            <%--</center>--%>
                                                            
                                                            <br />
                                                            
                                                            <table id="tblBillDetails" runat="server" border="0" cellspacing="1" cellpadding="4" style="width: 100%; color: #ff0000;" align="center" class="boxbg">
                                                                <tr class="bgbluegrey"> 
                                                                    <td colspan="4" align="center">
                                                                        <label class="blackfnt">
                                                                            <b>
                                                                                Bill List
                                                                            </b>    
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                                
                                                            <br />
                                                            
                                                            <center>
                                                                <table border="1" style="width: 98%; background-color: #808080" align="center" cellspacing="0" cellpadding="1" class="boxbg" id="Bill_Sumarry" runat="server">
                                                                <tr><td>
                                                                    <tr class="bgbluegrey">
                                                                        <td style="width: 10%">
                                                                            <label class="blackfnt">
                                                                                Sr. No.
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                Bill Number
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                Billing Branch
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                Party Name
                                                                            </label>
                                                                        </td>
                                                                                                                                                
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                Bill Type 
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                Bill Amount
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                Generation Date
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                Submission Date
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                Due Date
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                Collection Date
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                Submission Location 
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                               Collection Location 
                                                                            </label>
                                                                        </td>                                                                         
                                                                    </tr>
                                                                    
                                                                    <asp:Repeater ID="rptBillDetails" runat="server">
                                                                        <ItemTemplate>
                                                                            <tr style="background-color: White">
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "RowCounter")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">       
                                                                                     <asp:HyperLink Runat="server"  Font-Underline="True"  ForeColor="#003333" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "NavURL")%>' Text='<%#DataBinder.Eval(Container.DataItem, "BillNo")%>' ID="Hyperlink1">
                                                                                        </asp:HyperLink>                                                                                 
                                                                                            
                                                                                        </a>
                                                                                    </label>
                                                                                </td>                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "BillBrnach")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "PartyName")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "BillType")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "BillAmount")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "Gen_Date")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "Sub_Date")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "DueDate")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "Coll_Date")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "Sub_Loc")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "Coll_Loc")%>
                                                                                    </label>
                                                                                </td>
                                                                            </tr>
                                                                        </ItemTemplate>
                                                                    </asp:Repeater>                                                                    
                                                                   </td></tr>
                                                                </table>
                                                                
                                                                <%--Table for displaying no records found message--%>
                                                                <table id="tblNoRecords" runat="server" border="0" style="width: 98%; background-color: #808080" 
                                                                    align="center" cellspacing="1" cellpadding="2" class="boxbg" visible="false">
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td colspan="22" align="right" style="height: 34px">
                                                                            <div align="center">
                                                                                <label style="color: #FF0000;" class="blackfnt">
                                                                                    No Record Found
                                                                                </label>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </center>
                                                        </td>
                                                    </tr>
                                                </table>
                                                
                                                <br />
                                                <br />
                                                
                                                <table border="0" align="center" cellpadding="0" cellspacing="4" 
                                                    id="tblPageNavigation" runat="server">
                                                    <tr align="center">
                                                        <td align="center">
                                                            <label class="blackfnt">
                                                                Page&nbsp;
                                                                <asp:Label id="CurrentPage" CssClass="blackfnt" runat="server" />
                                                                &nbsp;of&nbsp;
                                                                <asp:Label id="TotalPages" CssClass="blackfnt" runat="server" />
                                                            </label>
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr align="center">
                                                        <td align="center">
                                                            <label class="blackfnt">
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" 
                                                                    id="FirstPage" Text="[First Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="First" />
                                                                
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" 
                                                                    id="PreviousPage" Text="[Previous Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="Prev" />
                                                                
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" 
                                                                    id="NextPage" Text="[Next Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="Next" />    
                                                                
                                                                <asp:LinkButton runat="server" CssClass="blackfnt" 
                                                                    id="LastPage" Text="[Last Page]" 
                                                                    OnCommand="NavigationLink_Click" CommandName="Last" />
                                                            </label>
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr align="center">
                                                        <td align="center">
                                                            <label class="blackfnt">
                                                            </label>
                                                            <select id="ddlPages" runat="server" class="blackfnt" onchange="PageSelectionChanged(this)" visible="false">
                                                            </select>
                                                            <input type="hidden" id="HIDCurrentPageNo" runat="server"/>
                                                        </td>
                                                    </tr>
                                                </table>
                                                
                                                <br />
                                                
                                                <center>
                                                    <asp:Button ID="btnXML" runat="server" OnClick="btnXML_Click" Text=" XML " />&nbsp;</center>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
        
</asp:Content>
