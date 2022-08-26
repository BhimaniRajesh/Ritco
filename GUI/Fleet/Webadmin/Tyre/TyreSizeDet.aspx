<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="TyreSizeDet.aspx.cs" Inherits="admin_TyreSizeDet" %>
 <asp:Content  ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
 <script type="text/javascript" language="JavaScript" src="../../../Js/querystring.js"></script>

   <script language="javascript">
           
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
	    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	    // IE
	    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    function checkTyreSize(txtSizeName)
    {
        var qs = new Querystring()
        var SIZE_ID = qs.get("id")
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        if (txtSizeName.value == "")
        {
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
                       txtSizeName.value=txtSizeName.value;
                    }
                    else
                    {
                        alert("Tyre Size is Already Exist !");
                        txtSizeName.value="";
                        txtSizeName.focus();
                    }
                }
            }
            xmlHttpRequest.open("GET", "../../../Fleet/Tyre/wfrm_AJAX_Validator.aspx?Function=CheckValidSizeName&datetime="+currentTime+"&SizeName=" + txtSizeName.value+"&sizeId="+SIZE_ID+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }	
    }
    function checkValidation()
    {
        var size = document.getElementById("ctl00$MyCPH1$txtSizeName").value;
        if(size=="")
        {
            alert("Please Enter Tyre Size!")
            document.getElementById("ctl00$MyCPH1$txtSizeName").focus()
            return false;
        }
        //////////////////////////////////////////////////////////////
        var type= document.getElementById("ctl00$MyCPH1$ddlTyreType").value;
        if(type=="00")
        {
            alert("Select Tyre Type!")
            document.getElementById("ctl00$MyCPH1$ddlTyreType").focus()
            return false;
        }
    }
   
</script>
  

    <asp:HiddenField ID="moreprod" runat="server" />
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Size Master</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    
    <br />
    <p align="left">
        <table cellspacing="1" cellpadding="3" style="width: 40%" class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td colspan="4" align="center" style="text-align: left">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Tyre Size Details"></asp:Label></td>
            </tr>
            <tr style="background-color: white">
                <td align="left" colspan="1" >
                    <asp:Label ID="lblTireID" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Size ID"></asp:Label>
                </td>
                <td align="left" colspan="1" >
                    <asp:Label ID="lblDriverIDVal" runat="server" CssClass="bluefnt" Text="Sys. Generated"></asp:Label>
                    <asp:HiddenField ID="hPrevDriverCode" runat="server" />
                </td>
               
                
                
                
                </tr>
                
                 <tr style="background-color: white">
               
                <td align="left" colspan="1">
                    <asp:Label ID="lblSizeName" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Size Name"></asp:Label>
                    <asp:RequiredFieldValidator ID="RFVProductType" runat="server" ControlToValidate="txtSizeName"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <td align="left" colspan="1" >
                <asp:TextBox ID="txtSizeName" runat="server" CssClass="input" MaxLength="100"></asp:TextBox>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
               
                
                
            </tr>
           
           
            

 




 <%--            <tr style="background-color: white">
               
                <td align="left" colspan="1" style="height: 28px" >
                    <asp:Label ID="lblMFGEntry" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Type Entry By:"></asp:Label>
                  
                </td>
                <td align="left" colspan="1" style="height: 28px">

                <asp:TextBox ID="txtTypeEntryBy" runat="server" CssClass="input" ></asp:TextBox>
                  </td>
                
            </tr>--%>
            <tr style="background-color: white">
                <td align="left" colspan="1">
                    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Tyre Type Category"></asp:Label></td>
                <td align="left" colspan="1">
                    <asp:DropDownList ID="ddlTyreType" runat="server"   Width="143px">
                    </asp:DropDownList></td>
            </tr>
            <!--<tr style="background-color: white">
                <td align="left" colspan="1">
                    <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Tyre Pattern"></asp:Label></td>
                <td align="left" colspan="1">
                    <asp:DropDownList ID="ddlTyrePattern" runat="server"   Width="143px">
                    </asp:DropDownList></td>
            </tr>-->
            
              <tr style="background-color: white">
               
                <td align="left" colspan="1" >
                    <asp:Label ID="lblStatus" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Active Flag"></asp:Label>
                  
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="cboActive"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <td align="left" colspan="1">
                    <asp:DropDownList ID="cboActive" runat="server"   Width="65px">
                     <asp:ListItem Text="Active" Value="Y"></asp:ListItem>
                                <asp:ListItem Text="Inactive" Value="N"></asp:ListItem>
                    </asp:DropDownList>
                  <%--  <asp:HiddenField ID="HiddenField1" runat="server" />--%>
                    
                </td>
                
                
                
                
            </tr>
       
              
              
           
                      
            
            <tr style="background-color: white">
                <td colspan="4" align="right">
                    <asp:Label ID="lblErrMsg" runat="server" Text="" CssClass="blackfnt" Font-Bold="true" ForeColor="red" Visible="false"></asp:Label>  
                    <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" OnClientClick="javascript:return checkValidation()" OnClick="cmdSubmit_Click"  />&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </p>
 </asp:Content>