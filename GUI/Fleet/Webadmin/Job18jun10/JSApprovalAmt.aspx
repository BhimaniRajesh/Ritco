<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="JSApprovalAmt.aspx.cs" Inherits="GUI_Fleet_Webadmin_Job_JSApprovalAmt" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

    <script language="javascript" type="text/javascript">
        var prefix = "ctl00_MyCPH1_";
        function createXMLHttpRequest()
        {
            // Mozilla, Safari,...
            if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
            // IE
            else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
        }
        function numeric(e) { return ((e.keyCode == 8) || (e.keyCode == 110) || (e.keyCode == 190) || (e.keyCode > 47 && e.keyCode <58)||(e.keyCode > 95 && e.keyCode <106) || (e.keyCode == 9) || (e.keyCode == 46));  }
        function roundNumber(num, dec) {num.value = Math.round(num.value*Math.pow(10,dec))/Math.pow(10,dec);}
        function check()
        {
            var currentTime = new Date()
            var ddlJobsheetType=document.getElementById(prefix+"ddlJobsheetType");
            var ddlLocationHierarchy=document.getElementById(prefix+"ddlLocationHierarchy");
            var txtApprovedAmt=document.getElementById(prefix+"txtApprovedAmt");
            var lbl_Error=document.getElementById(prefix+"lbl_Error");
            var hfID=document.getElementById(prefix+"hfID");
            
            if(ddlJobsheetType.value == "")
            {
                lbl_Error.innerText = "Select Jobsheet Type !!!";
                ddlJobsheetType.focus();
                return false;
            }
            else
            {
                lbl_Error.innerText = "";
            }
            if(ddlLocationHierarchy.value == "")
            {
                lbl_Error.innerText = "Select Location Hierarchy !!!";
                ddlLocationHierarchy.focus();
                return false;
            }
            else
            {
                lbl_Error.innerText = "";
            }
            if(txtApprovedAmt.value == "0")
            {
                lbl_Error.innerText = "Enter Amount !!!";
                txtApprovedAmt.focus();
                return false;
            }
            else
            {
                lbl_Error.innerText = "";
            }
            CheckValidRecord(ddlJobsheetType,ddlLocationHierarchy,hfID)
            
            if(bool == false)
            {
                return false;
            }
        }
        var bool=true;
        function CheckValidRecord(ddlJobsheetType,ddlLocationHierarchy,hfID)
        {
            var currentTime = new Date()
            createXMLHttpRequest();
            if (xmlHttpRequest)
            {
                xmlHttpRequest.onreadystatechange = function()
                {
                    if (xmlHttpRequest.readyState == 4)
                    {
                        var returnValue=xmlHttpRequest.responseText.split("~");
                        if (returnValue[0] == "Y") 
                        {
                            hfID.value=returnValue[1];
                            var answer = confirm("Already Esxit !!! Are you sure update record?");
	                        if (answer)
	                        {
	                            bool=true;
	                        }
	                        else
	                        {
	                            bool=false;
	                        }
                        }
                        else
                        {
                            bool=true;
                        }
                    }
                }
                xmlHttpRequest.open("GET", "../../Job/AJAX_Validator/AjaxResponse.aspx?Function=CheckValidData&datetime="+currentTime+"&JobSheetType="+ddlJobsheetType.value+"&LocHierarchy="+ddlLocationHierarchy.value, false);
                xmlHttpRequest.send(null);
            }
        }
    </script>
    
    <asp:UpdatePanel runat="server" ID="Up1" >
    <ContentTemplate>
    <table cellspacing="1" style="width: 800px ">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Jobsheet Approved Hierarchy Amount</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
            <td align="right">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                        <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                        <font class="blackfnt" color="red"><b>Please wait...</b></font>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>      
        </tr>
    </table>
    <br/>
    <br/>        
    <table  align="center"  class="boxbg" cellspacing="2" width="95%" >   
       <tr class="bgbluegrey">
                        <td colspan="4" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Jobsheet Approved Amount</asp:Label>
                        </td>
                    </tr>
        <tr  style="background-color: white">
            <td colspan="4" align="left">
                <asp:Label ID="lbl_Error" CssClass="redfnt"  runat="server" ></asp:Label>
                <asp:HiddenField ID="hfID" runat="server" Value="" />
            </td>
        </tr>
        <tr  style="background-color: white">
            <td width="30%" >
                Select Jobsheet Type 
            </td>
            <td  width="70%" >
                <asp:DropDownList ID="ddlJobsheetType" runat="server">
                    <asp:ListItem Text="--Select--" Value="" />
                    <asp:ListItem Text="Generate" Value="Generate" />
                    <asp:ListItem Text="Closure" Value="Closure" />
                </asp:DropDownList>
            </td>
        </tr>                                                                 
        <tr style="background-color: white">
            <td >
                Select Location Hierarchy 
            </td>
            <td >
                <asp:DropDownList ID="ddlLocationHierarchy" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
         <tr style="background-color: white">
            <td >
                Approved Amount
            </td>
            <td >
                <asp:TextBox ID="txtApprovedAmt" CssClass="input" Text="0" Width="100px"  Style="text-align: right" MaxLength="18" onkeydown="return numeric(event)" onBlur="return roundNumber(this,2)" runat="server"></asp:TextBox>
            </td>
        </tr>
         <tr style="background-color: white">
            <td colspan="2" >
                                                                                         

                 <asp:GridView ID="gvApprovedAmt" runat="server"    
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" width="100%"
                            HeaderStyle-CssClass="dgHeaderStyle"  PagerStyle-HorizontalAlign="left" >
                            <Columns>
                            <asp:BoundField DataField="CODEDESC" HeaderText="Location Hierarchy"></asp:BoundField>  
                            <asp:BoundField DataField="JS_TYPE" HeaderText="Jobsheet Type"></asp:BoundField>  
                            <asp:BoundField DataField="LOC_APPROVE_AMT" HeaderText="Approved Amount"></asp:BoundField>  
                            <asp:BoundField DataField="UPDATE_BY" HeaderText="Update By"></asp:BoundField> 
                            <asp:BoundField DataField="UPDATE_DT" HeaderText="Update Date"></asp:BoundField> 
                             
                            </Columns>
                        </asp:GridView>
            </td>
        </tr>
    </table>
    
     <table  align="center"   style="width: 100%"     >    
                       
                       <tr style="background-color: white" align="center">
                          <td  align="center" colspan="2">
                           <asp:Button ID="cmdSubmit" runat="server" Text="Submit"  OnClientClick="javascript:return check()"  OnClick="cmdSubmit_Click"   /> 
                           <asp:Button ID="btnReset" runat="server" Text="Reset"  OnClick="btnReset_Click"   /> 
                       </td>
                      </tr>
                     </table>
   
   
    
   </ContentTemplate>
                    <Triggers>
                     
                   
            <asp:AsyncPostBackTrigger ControlID="cmdSubmit" EventName="Click" />
 </Triggers>
   </asp:UpdatePanel>
</asp:Content>

