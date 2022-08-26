<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="CallReg_Step1.aspx.cs" Inherits="SFM_CallReg_Step1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    
    <script language="vbscript" type="text/vbscript">
        
        function findDateDifference(dtFrom, dtTo, interval)
            
            findDateDifference = DateDiff(interval, dtFrom, dtTo)
            
        end function
        
    </script>
    
 <script type="text/javascript" language="javascript" src="../CAL/datetimepicker.js"></script>
    <link href="../CAL/popcalendar.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../CAL/popcalendar.js"></script>
 <table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Visit Entry" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1"  color="#8ba0e5" />
            </td>
        </tr>
        </table>
       <%MyFunctions fn = new MyFunctions(); %>

<script language="javascript" type="text/javascript">

 var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");

function convertinUpper(obj)
                        {
                        obj.value = obj.value.toUpperCase()
                        }

            function Validation(cboCallType,txtPersonCalled,txtTime,txtDiscuss,txtMin,cboAccountCategory,txtOrderDate,txtOrderValue,txtdate)
            {
             
                                
             if(txtdate.value=="")
                    {
                    alert("Enter Call Date");
                    txtdate.focus();
                    return false;
                    }
//                    var server_dt="<%=DateTime.Now.ToString("dd MMM yyyy")%>"
//                    if(findDateDifference(txtdate.value, server_dt, "d") < 0)
//                    {
//                    alert("Call date should not be greater than today's date !!!");
//                    txtOrderDate.focus();
//                    return false;
//                    }
                    
//              
                    if(txtPersonCalled.value=="")
                    {
                    alert("Enter Person Called");
                    txtPersonCalled.focus();
                    return false;
                    }
                    
                if(cboCallType.value=="Select")
                    {
                    alert("Please Select Visit Type");
                    cboCallType.focus();
                    return false;
                    }
            
                 if(txtDiscuss.value=="")
                    {
                    alert("Enter Discussion Point");
                    txtDiscuss.focus();
                    return false;
                    }
                if(cboAccountCategory.value=="Select")
                    {
                    alert("Select Account Category");
                    cboAccountCategory.focus();
                    return false;
                    }
                if(cboAccountCategory.options.length==0)
                    {
                    alert("Please Add Account Status From General Master");
                    //cboAccountCategory.focus();
                    return false;
                    }
//                if(txtOrderDate.value=="")
//                    {
//                    alert("Enter Order Date");
//                    txtOrderDate.focus();
//                    return false;
//                    }
            
//                
                
                
                    
                    
                 }
     function validateTime(txtTime)
                 {
                 
                 if(txtTime.value!="")
                    {
                    var hour,min
                    var time = txtTime.value
                    var hourarr = time.split(':')
                    hour= hourarr[0];
                    min = hourarr[1];
                   
                   
                    if(parseInt(hour) > 23)
                        {
                        alert("PLease Enter Valid Time")
                        txtTime.focus()
                        return false;
                        }
                    if(parseInt(min) > 59)
                        {
                        alert("PLease Enter Valid Time")
                        txtTime.focus()
                        return false;
                        }
                    }
                    else
                    {
                        return true;
                    }
                    
                 }            
                 
                
  </script>
    
   

    
    
    <%--<script language="javascript" type="text/javascript">
    

            function Validation(cboCallType)
{

if(document.getElementById(cboCallType).value=="Select")

{
alert("Enter Call Type");
document.getElementById(cboCallType).focus();
//document.form1.cboCallType.focus();
return false;
}
   }

  </script>
--%>
   

    
    
        
            <table align="center" cellpadding="0" cellspacing="1" class="boxbg" width="85%">
            <tr class="bgbluegrey">
                <td align="center" class="bgbluegrey" style="height: 27px">
                <font class="blackfnt"><strong>Visit Registration</strong></font></td>
            </tr>
        </table>
        <br />
        <%
                DateTime dtNow=new DateTime();
                    dtNow = DateTime.Now;
               %>
        <table align="center" cellspacing="1" cellpadding="1" width="85%" border="0" class="boxbg" style="text-align: left">

               
                <tr bgcolor="white">
                    <td class="field1" style="width: 300px">
                        <font class="blackfnt">Call Id</font>
                    </td>
                    <td align="left" style="width: 138px" colspan="2">
                        &nbsp;<strong><span style="font-size: 8pt; color: #ff0000; font-family: Verdana">System
                            Genarated... </span></strong>
                    </td>
                    <td class="field1" style="width: 348px">
                         <font class="blackfnt">Call date</font>
                    </td>
                    <td align="left" style="width: 214px">
                        <asp:TextBox ID="txtdate" runat="server"></asp:TextBox>
                        
                        </td>
                </tr>
                
                <tr bgcolor="white">
                    <td class="field1" style="width: 300px; height: 21px;">
                         <font class="blackfnt">Prospect/Customer Id.</font>
                    </td>
                    <td align="left" style="width: 138px; height: 21px;" colspan="2">
                        <font class="blackfnt"><strong>
                            <asp:Label ID="custid" runat="server"></asp:Label><%--<%=Request.QueryString.Get("ProspectCode")%>--%><!--<input type=button class=inp value="..." onclick="fOpenInPopup('../webadmin/popup-prospectCust.asp?1')">--></strong></font></td>
                    
                    
                    <td class="field1" style="width: 348px; height: 21px;">
                         <font class="blackfnt">Entry Date</font>
                    </td>
                    <td align="left" style="width: 214px; height: 21px;">
                    <font class="blackfnt">
                        <%--<% dtNow.ToString("dd MMM yyyy");%>--%>
                         <font class="blackfnt">
                            <asp:Label ID="lblEntryDt" runat="server"></asp:Label></font>
                    </font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td class="field1"  style="width: 300px; height: 23px">
                         <font class="blackfnt">Person Met</font>
                    </td>
                    <td align="left"  style="height: 23px; width: 138px;" colspan="2">
                     <asp:TextBox ID="txtPersonCalled" runat="server" onBlur="return convertinUpper(this)" Width="154px"></asp:TextBox>  
                       
                    </td>
                    <td class="field1" style="width: 348px; height: 27px">
                         <font class="blackfnt">Time (In 24 hr. format)</font>
                    </td>
                    <td align="left" style="width: 138px; height: 27px;">
                        <font class="blackfnt">
                        <asp:TextBox ID="txtTime" runat="server" Style="left: 0px; position: relative; top: 0px"
                            Width="88px"></asp:TextBox>HH:MM<br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtTime"
                            ErrorMessage="Time is  required in HH:MM format" ValidationExpression="^\d{2}:\d{2}$"
                            Width="200px"></asp:RegularExpressionValidator></font>
                    </td>
                </tr>
                
                <tr bgcolor="white" >
                    <td class="field1" style="width: 300px">
                    <font class="blackfnt">Discussion points</font>
                       
                    </td>
                    <td align="left" style="width: 61px" colspan="2">
                      <asp:TextBox ID="txtDiscuss" runat="server" Height="56px" onBlur="return convertinUpper(this)" Width="200px" TextMode="MultiLine"></asp:TextBox>  
                        
                        
                    </td>
                    <td style="width: 348px; height: 27px" ><font class="blackfnt" >Duration in min.</font></td>
                    <td>
                    <asp:TextBox ID="txtMin" runat="server" Width="88px"></asp:TextBox>&nbsp;<br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtMin"
                        ErrorMessage="Enter duration in minute" Font-Size="Small" Style="left: 0px; position: relative;
                        top: 8px" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>  
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td class="field1" style="width: 300px; height: 22px;">
                        <font class="blackfnt">Visit Type</font>
                    </td>
                    <td align="left" style="width: 138px; height: 22px;" colspan="2" >
                        <font class="blackfnt">
                        <asp:DropDownList ID="cboCallType" runat="server" Width="120px">
                            <asp:ListItem>Visit</asp:ListItem>
                            <asp:ListItem>Phone</asp:ListItem>
                            <asp:ListItem>E-mail</asp:ListItem>
                            <asp:ListItem>SMS</asp:ListItem>
                            <asp:ListItem>Chat</asp:ListItem>
                        </asp:DropDownList><br />
                    </font> 
                        
                    </td>
                    <td style="width: 348px; height: 22px;">
                        <font class="blackfnt">Account Status</font>
                   </td>
                   <td style="height: 22px">
                   <font class="blackfnt">
                        <asp:DropDownList ID="cboAccountCategory" runat="server" Width="120px">
                            <asp:ListItem>Select</asp:ListItem>
                            <%--<asp:ListItem>Hot</asp:ListItem>
                            <asp:ListItem>Warm</asp:ListItem>
                            <asp:ListItem>Cold</asp:ListItem>--%>
                        </asp:DropDownList></font>
                   
                     </td>
                    
                </tr>
                
                <tr bgcolor="white">
                    <td class="field1" style="width: 300px; height: 22px;">
                        <font class="blackfnt">Likely order date</font>
                    </td>
                    <td align="left" style="width: 138px; height: 22px;" colspan="2">
                         <asp:TextBox ID="txtOrderDate" runat="server"></asp:TextBox></td>
                          <td class="field1" style="width: 348px; height: 22px;">
                        <font class="blackfnt">Likely Order Value (In Rs.)</font>
                    </td>
                    <td align="left" style="width: 138px; height: 22px;" >
                         <asp:TextBox ID="txtOrderValue" runat="server"></asp:TextBox></td>
                     
                </tr>
                
                
          </table>
          <br />
        <table align="center" cellspacing="1" cellpadding="1" width="85%" border="0">
        <tr bgcolor="white" align="center">
                    
                    <td style="width: 138px; height: 22px;" colspan="6">
                         <asp:Button ID="btnSubmit" runat="server" Height="24px" Text="Submit" Width="80px" style="left: 342px; position: relative; top: -1px" OnClick="btnSubmit_Click" />
                    </td>
                </tr>
        </table>
    
    
</asp:Content>
