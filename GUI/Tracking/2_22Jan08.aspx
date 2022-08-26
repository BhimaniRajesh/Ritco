<%@ Page Language="C#" CodeFile="2.aspx.cs" AutoEventWireup="true"  Inherits="GUI_Tracking_2" %>
<%@ Register Src="TabsView.ascx" TagName="TabsView" TagPrefix="uc1" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<title>Untitled Page</title>
    <link href="../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<form id="form1" runat="server">


    <script language="javascript" type="text/javascript">
function OpenPopupWindow1(strDocketNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../GUI/Operation/Singlescreen_docketentry/DocketPrint/DocketView_xls.aspx?dockno=" + strDocketNo    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
         function topWindowPOD(strDocketNo1)
        {
        
            var strWinFeature1 = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
             
              var client="<%=Session["Client"]%>"
            var strPopupURL1 = "../../GUI/Operations/FM/FMDocuments/"+client+"/" + strDocketNo1   
           
            winNew = window.open(strPopupURL1, "_blank", strWinFeature1)
            
        }
        
         function topTrackPOD(strDocketNo1)
        {
        
            var strWinFeature1 = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=340,status=no,left=60,top=270"
             
            
            var strPopupURL1 = "./Track_POD.aspx?" + strDocketNo1   
           
            winNew = window.open(strPopupURL1, "_blank", strWinFeature1)
            
        }
        
        function OpenPopupWindow1ls(strDocketNo1)
        {
       // alert(strDocketNo1)
            var strWinFeature1 = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
             //alert(strWinFeature1)
            var strPopupURL1 = "../../GUI/Operations/TCS/PrintTCS/ViewAndPrintLoadingSheet.aspx?MFNo=" + strDocketNo1   
           
            winNew = window.open(strPopupURL1, "_blank", strWinFeature1)
            
        }
        
        function OpenPopupWindowLS(strLS)
        {
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "../../GUI/Operations/LoadingSheet/ViewPrint/LoadingSheetSummaryList.aspx?lsno="+strLS  
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
        
        function OpenPopupWindow2(strDocketNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../GUI/Operation/Singlescreen_docketentry/DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno=" + strDocketNo    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        function OpenWindow(strMF)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "../../GUI/Operations/TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" + strMF    
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
        function OpenWindowTHC(strTHC)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "../../GUI/Operations/THC/ViewPrint/THCViewPrint.aspx?tcno=" + strTHC + "."    
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
        function OpenPopupWindowPRS(pdcno)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strPopupURL = "../../GUI/Operations/PRS/PRS_View_Print.aspx?DRSNo=" + pdcno
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
        function OpenWindowDRS(pdcno)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../GUI/Operations/DRS/DRS_View_Print.aspx?DRSNo=" + pdcno
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
        function OpenPopupWindowMR(mrsno)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../GUI/Operation/Singlescreen_docketentry/DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno=" + mrsno    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
        
        function OpenPopupWindowOCTNO(mrsno)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../GUI/Operation/Singlescreen_docketentry/DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno=" + mrsno    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
        function OpenPopupWindowBMNO(mrsno)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../GUI/Operation/Singlescreen_docketentry/DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno=" + mrsno    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
        
         function OpenPopupWindowBillNo(mrsno)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../GUI/Finance/Billing/BillViewPrint/BillNo_Popup.aspx?Bill_No=" + mrsno    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
</script>
<%-- <atlas:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"/>--%>
<atlas:ScriptManager ID="scmn1" runat="server" EnableViewState="true" EnableScriptComponents="true"></atlas:ScriptManager>
<div>

<%-- Tab2Title="View & Print"
 Tab5Title="Movement"
                        Tab6Title="Exception"--%>
<uc1:TabsView ID="TabsView1"  align="centre"  runat="server"  OnTabChanged="TabsView1_OnTabChanged" 
                        Tab1Title="    Summary   " 
                        Tab2Title="Operation"
                        Tab3Title="Finance"
                       >
                      
                        
                        
                        <Tab1>
                            <br />
                          
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline"       UpdateMode="Conditional">
                                 <Triggers>
                                            </Triggers><ContentTemplate>
                                    <table  align="center" border="0" cellspacing="1" cellpadding="3" style="width: 90%" >
                                       
                                        <tr   bgcolor="white">
                                            <td align="center"  colspan="9"><font class=blackfnt><!-- #include file="./Docket_Summary.aspx"--></font></td>
                                             
                                        </tr>
                                         
                                      </table>
                                     
                                     </ContentTemplate>
                                  </asp:UpdatePanel>
                        </Tab1>
                        
                       
                        
                        <Tab2>
                         <br /><asp:UpdatePanel ID="UpdatePanel3" runat="server" RenderMode="Inline"      UpdateMode="Conditional">
                                <Triggers>
                                            </Triggers> <ContentTemplate>
                                   <table  align="center" border="0" cellspacing="1" cellpadding="3" style="width: 90%" >
                                       
                                        <tr   bgcolor="white">
                                            <td align="center"  colspan="9"><font class=blackfnt><!-- #include file="./Docket_life_operation.aspx"--></font></td>
                                             
                                        </tr>
                                         
                                      </table>
                                     </ContentTemplate>
                                  </asp:UpdatePanel></Tab2>
                                  
                          <%-- <Tab4>
                            <br /><asp:UpdatePanel ID="UpdatePanel4" runat="server" RenderMode="Inline"     UpdateMode="Conditional">
                                 <Triggers>
                                            </Triggers><ContentTemplate>
                                    <table cellspacing="1" cellpadding="3" style="width: 100%" class="boxbg">
                                        <tr class="bgbluegrey">
                                            <td align="center"  colspan="8"><font class=blackfnt>Finance</font></td>
                                             <td align="center" colspan="8"></td>
                                        </tr>
                                      </table>
                                     </ContentTemplate>
                                  </asp:UpdatePanel></Tab4>--%>
                                  
                                   <Tab3>
                         <br /><asp:UpdatePanel ID="UpdatePanel4" runat="server" RenderMode="Inline"     UpdateMode="Conditional">
                                <Triggers>
                                            </Triggers> <ContentTemplate>
                                   <table  align="center" border="0" cellspacing="1" cellpadding="3" style="width: 90%" >
                                       
                                        <tr   bgcolor="white">
                                            <td align="center"  colspan="9"><font class=blackfnt><!-- #include file="./Docket_life_Finance.aspx"--></font></td>
                                             
                                        </tr>
                                         
                                      </table>
                                     </ContentTemplate>
                                  </asp:UpdatePanel></Tab3>
                                 <%-- 
                                 
                                 <%--  <Tab2>
                            <br />
                          
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" RenderMode="Inline"   UpdateMode="Conditional">
                                <Triggers>
                                            </Triggers> <ContentTemplate>
                                   <table  align="center" border="0" cellspacing="1" cellpadding="3" style="width: 90%" >
                                       
                                        <tr   bgcolor="white">
                                            <td align="center"  colspan="9"><font class=blackfnt><!-- #include file="./Docket_ViewPrint.aspx"--></font></td>
                                             
                                        </tr>
                                         
                                      </table>
                                     </ContentTemplate>
                                  </asp:UpdatePanel>
                        </Tab2>
                                  <Tab5>
                         <br /><asp:UpdatePanel ID="UpdatePanel5" runat="server" RenderMode="Inline"  UpdateMode="Conditional">
                                <Triggers>
                                            </Triggers> <ContentTemplate>
                                   <table  align="center" border="0" cellspacing="1" cellpadding="3" style="width: 90%" >
                                       
                                        <tr   bgcolor="white">
                                            <td align="center"  colspan="9"><font class=blackfnt><!-- #include file="./Docket_Movment.aspx"--></font></td>   
                                        </tr>
                                      </table>
                                     </ContentTemplate>
                                  </asp:UpdatePanel></Tab5>--%>
                        
                        </uc1:TabsView>
                  
</div>

</form>
</body>
</html>

