<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="TyreOdometerSearch.aspx.cs" Inherits="TyreOdometerSearch" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
  <script language="javascript">
    function PopupWindow(txtVehNo)
    {
        if(txtVehNo.value == "")
        {
            alert("Select Vehicle No!!!")
            txtVehNo.focus();
            return false;
        }
        if(txtVehNo.value != "")
        {
            window.open ("ViewTyreOdometer.aspx?Vehno="+txtVehNo.value+"","new_win","location=1,status=1,scrollbars=1,width=600,height=500,scrollbars=yes"); 
            return true;
        }
    }
    function PopupWindowP(txtVehNo)
    {
        if(txtVehNo.value == "")
        {
            alert("Select Vehicle No!!!")
            txtVehNo.focus();
            return false;
        }
        if(txtVehNo.value != "")
        {
            window.open ("ViewTyreOdometer.aspx?print=0&Vehno="+txtVehNo.value+"","new_win","location=1,status=1,scrollbars=1,width=600,height=500,scrollbars=yes"); 
            return true;
        }
    }
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
	    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	    // IE
	    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    function checkVehNo(txtVehNo,hfVehIntId)
    {
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        var str_Index = "";
        if (txtVehNo.value == "")
        {
            txtVehNo.value="";
            hfVehIntId.value="";
            return;
        }

        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") 
                    {
                        alert("Invalid Vehicle Number");
                        txtVehNo.value="";
                        hfVehIntId.value="";
                        txtVehNo.focus();
                    }
                    else
                    {
                        txtVehNo.value=returnValue[1];
                        hfVehIntId.value=returnValue[2];
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckValidVehNo&datetime="+currentTime+"&VehNo=" + txtVehNo.value+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }	
    }
 
   </script>
 
 
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 3px; font-weight: bold; vertical-align: top; color: #006633; text-align: left;">
               <br /> VEHICLE ODOMETER CHANGE<br />
                <br />
                <hr />  
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="vertical-align: top; text-align: left">
             <table cellspacing="1" style="width: 60%" class="boxbg">
                 <tr style="background-color: white">
                     <td align="right" colspan="3" style="text-align: left">
                <table cellspacing="1" style="width: 100%">
                    <tr style="background-color: white">
                        <td align="left" style="height: 26px">
                            <asp:Label ID="lblNew" runat="server" CssClass="blackfnt" Font-Bold="true" Text="New ?? "></asp:Label>
                            <asp:LinkButton ID="lnkCreateDriver" runat="server" Text="Create New" CssClass="bluefnt" Font-Bold="true" PostBackUrl="~/GUI/Fleet/Tyre/TyreOdometer.aspx"  ValidationGroup="VGCreate"></asp:LinkButton></td>
                        <td align="left" colspan="3" style="height: 26px; text-align: right">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                            <ContentTemplate>
                      
                            <asp:LinkButton ID="lnkbtnView" runat="server" CssClass="bluefnt" Font-Bold="True">View</asp:LinkButton>
                            <asp:Label ID="Label2" runat="server" Text="|"></asp:Label>
                            <asp:LinkButton ID="lnkbtnPrint" runat="server" CssClass="bluefnt" Font-Bold="True">Print</asp:LinkButton>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        </td>
                        <td align="left" style="width: 7px; height: 26px">
                            <asp:Label ID="Label3" runat="server" Text="|"></asp:Label></td>
                        <td align="left" style="width: 7px; height: 26px;">
                            <asp:LinkButton ID="lnkbtnXLS" runat="server" OnClick="lnkbtnXLS_Click" CssClass="bluefnt" Font-Bold="True">XLS</asp:LinkButton></td>
                    
                    </tr>
                </table>
                     </td>
                 </tr>
                       <tr style="background-color: white">
                        <td align="right" style="width: 25%; text-align: left">
                  
                            <asp:Label ID="lblTyreSize" runat="server" Text="Enter Vehicle No."  Font-Bold="True" CssClass="blackfnt"></asp:Label>
                  
                    </td>
                            <td align="left" colspan="2" style="width: 75%">
                                <asp:TextBox ID="txtVehNo" runat="server" AutoCompleteType="Notes" Width="130px"></asp:TextBox><asp:Button
                                    ID="btnPopupVehno" runat="server" Text="..." Width="21px" />
                                    
                                    <%--<asp:AutoCompleteExtender
                                        ID="AutoCompleteExtender4" runat="server" DropDownPanelID="Panel4" ServiceMethod="GetVehNo"
                                        ServicePath="~/services/AutoComplet.asmx">
                                        <asp:AutoCompleteProperties Enabled="true" MinimumPrefixLength="1" TargetControlID="txtVehNo" />
                                    </asp:AutoCompleteExtender>--%>
                                <asp:HiddenField ID="hfVehIntId" runat="server" />
                                <asp:HiddenField ID="hfkm" runat="server" />
                              <%--  <asp:Panel ID="Panel4" runat="server" BackColor="transparent" BorderStyle="Inset"
                                    BorderWidth="1px" Direction="LeftToRight" Font-Names="Verdana" Font-Overline="False"
                                    Font-Size="8pt" Font-Underline="False" Height="200px" HorizontalAlign="Left"
                                    ScrollBars="Vertical">
                                </asp:Panel>--%>
                                </td>
                  </tr>
                    <tr style="background-color: white">
                        <td colspan="3" align="right">
                            <asp:UpdatePanel ID="UPShowTyre" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnShowTyre" runat="server" Text="Show >>" ValidationGroup="VGDtFromTo" 
                                        OnClick="btnShowTyre_OnClick" />
                                    <asp:UpdateProgress runat="server" ID="Prog1">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgWait" ImageUrl="~/GUI/images/indicator.gif" runat="server" BorderStyle="none" />
                                            <%--                                            <asp:Label ID="lblProgress" CssClass="blackfnt" Text="Wait.." runat="server" ForeColor="Red"></asp:Label>
--%>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                      
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                 <tr style="background-color: white">
                     <td align="right" colspan="3" style="width: 100%; text-align: left"><asp:UpdatePanel runat="server" ID="UpdatePanel1">
                         <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" BorderWidth="1px" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="50" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"  
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" DataKeyNames="Tran_No" Width="100%">
                            <Columns>
                               
                                <asp:BoundField DataField="VehNo" HeaderText="Vehicle No."> 
                                    <ItemStyle HorizontalAlign="Left" Width="40%" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="Last_Km_Reading" HeaderText="Last KM Reading" >
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               
                               
                                <asp:BoundField DataField="Odometer_Reading" HeaderText="Odometer Reading">
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="Odometer_Reading_Dt" HeaderText="Odometer Reading Date">
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                  <asp:BoundField DataField="Odometer_Reason" HeaderText="Odometer Reason">
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                               <%-- <asp:HyperLinkField DataTextFormatString="--Select--" DataTextField="TYRE_SIZEID" DataNavigateUrlFields="TYRE_SIZEID"
                                    DataNavigateUrlFormatString="TyreSizeDet.aspx?id={0}" >
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" HorizontalAlign="Center" Width="10%" />
                                </asp:HyperLinkField>--%>
                               
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                         </ContentTemplate>
                     </asp:UpdatePanel>
                     </td>
                 </tr>
                
                </table>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left">
                </td>
        </tr>
    </table>

 
 </asp:Content>
