<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"     CodeFile="DocumentRegister.aspx.cs" Inherits="GUI_Fleet_Reports_TyreRegister" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript">
     function openReportParentWindow(url)
        {
            alert("1")
          w=screen.width-10;
          h=screen.height-10;
          wleft = (screen.width - w) / 2;
          wtop = (screen.height - h) / 2;
          if (wleft < 0)  { w = screen.width;
                            wleft = 0;         }
          if (wtop < 0)   { h = screen.height;
                            wtop = 0;          }
          var win = window.open(url+'?Screen_Height='+(screen.height-160),'Report_Register_Order','width=' + w + ', height=' + h + ', ' +
            'left=' + wleft + ', top=' + wtop + ',resizable=no,scrollbars=yes,status=yes'); 
          win.resizeTo(w, h-30);
          win.moveTo(wleft, wtop);
          win.focus();
        }
        
        function SelectAll(chk,chklist)
        {
            var checkBoxList = chklist;
            if(chk.checked == true)
            {
                if(checkBoxList !=null)
                {
                    var options = checkBoxList.getElementsByTagName('input');
                    var arrayOfCheckBoxLabels= checkBoxList.getElementsByTagName("label");
                    for(i=0;i<options.length;i++)
                    {
                        var opt = options[i];
                        opt.checked = true;
                    } 
                }
            }
            else
            {
                if(checkBoxList !=null)
                {
                    var options = checkBoxList.getElementsByTagName('input');
                    var arrayOfCheckBoxLabels= checkBoxList.getElementsByTagName("label");
                    for(i=0;i<options.length;i++)
                    {
                        var opt = options[i];
                        opt.checked = false;
                    } 
                }
            }
        }
         function OnSub_DATACHECK()
    {
        var hdnRptId = document.getElementById("ctl00_MyCPH1_hdnRptId"); // added by Manisha 20/5/2014
        window.open("DocumentRegisterRes.aspx?hdnRptId=" + hdnRptId.value + "", "");
        return false;
    }
     
    </script> 


   <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 20/5/2014 --%>

<asp:UpdateProgress ID="uppMain" runat="server">
    <ProgressTemplate>
        <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
            -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
            <tr>
                <td align="right">
                    <img src="../../images/loading.gif" alt="" />
                </td>
                <td>
                    <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                </td>
            </tr>
        </table>
        <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
            background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
            opacity: .50; -moz-opacity: .50;" runat="server">
            <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                left: 50%;" ID="Panel2" runat="server">
            </asp:Panel>
        </asp:Panel>
    </ProgressTemplate>
</asp:UpdateProgress>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Document Register</asp:Label>
            </td> 
            
             <td align="right">

          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
    <asp:UpdatePanel ID="UpdatePanel2" RenderMode="Inline" runat="server">
        <ContentTemplate>
    
      
      <table cellspacing="1" style="width: 700px">
            <tr >
                <td>  
       <table cellspacing="1" cellpadding="2" style="width: 100%" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="3" align="center" style="vertical-align: top; width: 30%; text-align: center; font-weight: bold; font-family: Verdana; height: 20px;">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                            <td align="center" colspan="1" style="width: 20%; text-align: left; height: 20px;">
                            </td>
                        </tr>
           <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 17%; text-align: left">
                            <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True">Select Vehicle No:</asp:Label></td>
                        <td align="left" colspan="2" style="width: 16%">
                          <asp:TextBox ID="txtVehNo" runat="server" AutoCompleteType="Notes" Width="140px"></asp:TextBox>
                <asp:Button ID="btnPopupVehno" runat="server" Text="..." Width="21px" />
             <%--   <asp:AutoCompleteExtender ID="au" runat="server" DropDownPanelID="pnlDropdown"
                    ServiceMethod="GetVehNo" ServicePath="../../../GUI/services/DocumentMgtWebService.asmx">
                    <atlas:AutoCompleteProperties Enabled="true" MinimumPrefixLength="1" TargetControlID="txtVehNo" />
                </atlas:AutoCompleteExtender>--%>
                <asp:HiddenField ID="hfVehcate" runat="server" />
                <asp:HiddenField ID="hfVehType" runat="server" />
                <asp:HiddenField ID="hfKm" runat="server" />
                 <asp:HiddenField ID="hfVehIntId" runat="server" />
                            </td>
               <td align="left" colspan="1" style="width: 20%; text-align: left">
                            </td>
                    </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 17%; text-align: left">
                   <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True">Select Document Type:</asp:Label></td>
               <td align="left" colspan="2" style="width: 16%">
                   <asp:DropDownList ID="ddlDocumentType" runat="server" Font-Names="Verdana" Font-Size="8pt"
                       Width="146px" AutoPostBack="True" OnSelectedIndexChanged="ddlDocumentType_SelectedIndexChanged">
                   </asp:DropDownList></td>
               <td align="left" colspan="1" style="width: 20%; text-align: left">
               </td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 17%; text-align: left">
                   <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="True">Select renewal authority:</asp:Label></td>
               <td align="left" colspan="2" style="width: 16%">
                   <asp:DropDownList ID="ddlRenewAutu" runat="server" Font-Names="Verdana" Font-Size="8pt"
                       Width="146px">
                   </asp:DropDownList></td>
               <td align="left" colspan="1" style="width: 20%; text-align: left">
               </td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 17%; text-align: left">
                   <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="True">Expiry status:</asp:Label></td>
               <td align="left" colspan="2" style="width: 16%">
                   <asp:DropDownList ID="ddlStatus" runat="server" Font-Names="Verdana" Font-Size="8pt"
                       Width="146px" AutoPostBack="True" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                       <asp:ListItem Value="All">All</asp:ListItem>
                       <asp:ListItem Value="Already Expired">Already Expired</asp:ListItem>
                       <asp:ListItem Value="Yet to Expire">Yet to Expire</asp:ListItem>
                   </asp:DropDownList></td>
               <td align="left" colspan="1" style="width: 20%; text-align: left">
               </td>
           </tr>
           <tr runat="server" id="rowN"  style="background-color: white">
               <td align="right" style="vertical-align: top; width: 17%; text-align: left">
                   <asp:Label ID="Label6" runat="server" CssClass="blackfnt" Font-Bold="True">Select expiry date range:</asp:Label></td>
               <td align="left" colspan="2" style="width: 16%">
                   <asp:RadioButtonList ID="rblExpiryDateRange" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblExpiryDateRange_SelectedIndexChanged">
                       <asp:ListItem Value="0">In next 7 days</asp:ListItem>
                       <asp:ListItem Value="1">From today till specified date</asp:ListItem>
                       <asp:ListItem Value="2">Show all documents</asp:ListItem>
                   </asp:RadioButtonList></td>
               <td align="left" colspan="1" style="vertical-align: top; width: 20%; text-align: left">
                   <asp:TextBox ID="txtDateFrom" runat="Server" BorderStyle="Groove" CssClass="input"
                       ValidationGroup="VGDtFromTo" Visible="False" Width="80"></asp:TextBox>
                       <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" 
                                        Format="dd/MM/yyyy"
                                        TargetControlID="txtDateFrom"   runat="server" />
                       </td>
           </tr>
           <tr style="background-color: white">
               <td align="left" colspan="4" style="font-weight: bold;
                   width: 30%; text-align: center; font-size: 8pt; vertical-align: top; font-family: Verdana;">
                   OR</td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 17%; text-align: left">
                   <asp:Label ID="Label19" runat="server" CssClass="blackfnt" Font-Bold="True">Specify document number:</asp:Label></td>
               <td align="left" colspan="2" style="width: 16%;">
                   <asp:TextBox ID="txtTyre" runat="server" CssClass="input" Style="font-size: 8pt;
                       font-family: Verdana" Width="181px"></asp:TextBox>&nbsp;
               </td>
               <td align="left" colspan="1" style="width: 20%; text-align: left">
                   </td>
           </tr>

                       </table>
                    
                   </td>
            </tr>
        </table>
   
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    &nbsp;<table cellspacing="1" cellpadding="2" style="width: 700px" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="3" align="center" style="vertical-align: top; width: 30%; text-align: left">
                                  <asp:Panel ID="pnlTyreSummary" runat="server" CssClass="collapsePanelHeader" Width="100%" Height="20px" > 
                    <div style="padding:5px; cursor: pointer; vertical-align: middle;">
                            
                        &nbsp;<asp:Label ID="Label20" CssClass="blackfnt" Font-Bold="True" runat="server">Report Columns</asp:Label>
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        <asp:Label ID="lblTyreSH" runat="server" Font-Bold="True">Show...</asp:Label></div>
    </asp:Panel>
                            </td>
                        </tr>
           <tr style="background-color: white">
               <td align="left" colspan="3">
                
                 <asp:Panel ID="pnlTyreSummary1" runat="server" CssClass="collapsePanel" Height="0" Width="100%">
                <asp:CheckBox ID="chkSelAllRepoColumn"  Text="Select All" runat="server" Font-Italic="True" />
                   <asp:CheckBoxList ID="chkRepoColumns" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" Width="100%">
                       <asp:ListItem Value="0">Vehicle Number</asp:ListItem>
                       <asp:ListItem Value="1">Vehicle Type</asp:ListItem>
                       <asp:ListItem Value="2">Document Type</asp:ListItem>
                       <asp:ListItem Value="3">Document Description</asp:ListItem>
                       <asp:ListItem Value="4">Document Number</asp:ListItem>
                       <asp:ListItem Value="5">Renewal Auturity</asp:ListItem>
                       <asp:ListItem Value="6">Renewal Auturity Name</asp:ListItem>
                       <asp:ListItem Value="7">Start Date</asp:ListItem>
                       <asp:ListItem Value="8">Expiry Date</asp:ListItem>
                       <asp:ListItem Value="9">Cost</asp:ListItem>
                       <asp:ListItem Value="10">States</asp:ListItem>
                       <asp:ListItem Value="11">Scanned Document</asp:ListItem>
                   
                   </asp:CheckBoxList></asp:Panel>
           
          <ajaxToolkit:CollapsiblePanelExtender ID="cpe" runat="Server"
                TargetControlID="pnlTyreSummary1"
                    ExpandControlID="pnlTyreSummary" CollapseControlID="pnlTyreSummary" Collapsed="True"
                     TextLabelID="lblTyreSH" ExpandedText="Hide..." CollapsedText="Show..."
                     SuppressPostBack="true">
            </ajaxToolkit:CollapsiblePanelExtender>
               </td>
           </tr>
           
           
           </table>
    <br />
    
    
  <table cellspacing="1" cellpadding="2" style="width: 700px" class="boxbg">
    <tr class="bgbluegrey">
        <td colspan="3" align="center" style="vertical-align: middle; width: 30%; text-align: center">
            <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnShow" runat="server" Text="Submit"  OnClick="btnShow_Click" OnClientClick="Javascript: return OnSub_DATACHECK();"  /> 
                    <%--OnClientClick="javascript:openReportParentWindow('DocumentRegisterRes.aspx')"  --%>                    
                    </ContentTemplate>
                </asp:UpdatePanel>  
        </td>
    </tr>
   </table>
    

  
   
</asp:Content> 