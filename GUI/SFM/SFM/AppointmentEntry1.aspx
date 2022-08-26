<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AppointmentEntry1.aspx.cs" Inherits="SFM_AppointmentEntry1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

 <script type="text/javascript" language="javascript" src="../CAL/datetimepicker.js"></script>
    <link href="../CAL/popcalendar.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../CAL/popcalendar.js"></script>
    <script language="javascript" type="text/javascript">
    
    function Validation(txtCustCode,txtAppDate,txtTime,txtPersonMet,txtContactNo,txtDepartment,txtDesignation,txtPurposeofVisit)
        {
        
                    if(txtCustCode.value=="")
                    {
                    alert("Enter Prospect Code");
                    txtCustCode.focus();
                    return false;
                    }
                    if(txtAppDate.value=="")
                    {
                    alert("Enter Appointment Date");
                    txtAppDate.focus();
                    return false;
                    }
                    if(txtTime.value=="")
                    {
                    alert("Enter Time");
                    txtTime.focus();
                    return false;
                    }
                    if(txtPersonMet.value=="")
                    {
                    alert("Enter Person to Met");
                    txtPersonMet.focus();
                    return false;
                    }
                    if(txtContactNo.value=="")
                    {
                    alert("Enter Contact No.");
                    txtContactNo.focus();
                    return false;
                    }
//                    if(txtDepartment.value=="")
//                    {
//                    alert("Enter Department");
//                    txtDepartment.focus();
//                    return false;
//                    }
//                    if(txtDesignation.value=="")
//                    {
//                    alert("Enter Designation");
//                    txtDesignation.focus();
//                    return false;
//                    }
                    if(txtPurposeofVisit.value=="")
                    {
                    alert("Enter Purpose of Visit");
                    txtPurposeofVisit.focus();
                    return false;
                    }
                    
        
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
                        alert("Please Enter Valid Time")
                        txtTime.focus()
                        return false;
                        }
                    if(parseInt(min) > 59)
                        {
                        alert("Please Enter Valid Time")
                        txtTime.focus()
                        return false;
                        }
                    }
                 }
    </script>
    <div align="center">
    
    <table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Appointment Entry" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />

<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right" style="height: 33px">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../images/back.gif" /></a>
                    </td>
                </tr>
            </table>
            <br />
     <%
                DateTime dtNow=new DateTime();
                    dtNow = DateTime.Now;
               %>
<table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                            cols="1" width="85%">
                            <tr class="bgbluegrey">
                                                        <td align="center" colspan="5">
                                                            <font class="blackfnt"><strong>Enter Appointment</strong></font></td>
                                                    </tr>
                            
                
                
                <tr bgcolor="white">
                    <td align="left" class="field1" style="width: 300px; height: 21px;">
                         <font class="blackfnt">Prospect/Customer Id.</font>
                    </td>
                    <td align="left" style="width: 138px; height: 21px;" colspan="2">
                    
                    <asp:TextBox ID="txtCustCode" runat="server" Width="60px"></asp:TextBox>                                            
                    <input id="btnCust" type="button" name="" runat="server"/>
                       
                    </td>
                    <td align="left" class="field1" style="width: 348px; height: 21px;">
                         <font class="blackfnt">Entry Date</font>
                    </td>
                    <td align="left" style="width: 214px; height: 21px;">
                  <asp:TextBox ID="txtEntrydate" runat="server" Width="60"></asp:TextBox>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" class="field1">
                         <font class="blackfnt">Appointment Date</font>
                    </td>
                    <td align="left" colspan="2">
                     <asp:TextBox ID="txtAppDate" runat="server" Width="88px"></asp:TextBox>  
                       
                    </td>
                    <td align="left" class="field1">
                         <font class="blackfnt">Time (In 24 hr. format)</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                        <asp:TextBox ID="txtTime" runat="server" 
                            Width="88px"></asp:TextBox>HH:MM
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtTime"
                            ErrorMessage="Time is  required in HH:MM format" ValidationExpression="^\d{2}:\d{2}$"
                            Width="200px"></asp:RegularExpressionValidator></font>
                    </td>
                </tr>
                
                <tr bgcolor="white" >
                    <td align="left" class="field1" style="width: 300px">
                    <font class="blackfnt">Person to be Met</font>
                       
                    </td>
                    <td align="left" style="width: 138px; height: 22px;" colspan="2">
                      <asp:TextBox ID="txtPersonMet" runat="server" Width="88px"></asp:TextBox>  
                        
                        
                    </td>
                    <td align="left" style="width: 348px; height: 27px" ><font class="blackfnt" >Contact Number</font></td>
                    <td align="left">
                    <asp:TextBox ID="txtContactNo" runat="server" Width="88px"></asp:TextBox>&nbsp;<br />
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" class="field1" style="width: 300px; height: 22px;">
                        <font class="blackfnt">Department</font>
                    </td>
                    <td align="left" style="width: 138px; height: 22px;" colspan="2" >
                        <asp:TextBox ID="txtDepartment" runat="server" Width="88px"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 348px; height: 22px;">
                        <font class="blackfnt">Designation</font>
                   </td>
                   <td align="left" style="height: 22px" >
                   <asp:TextBox ID="txtDesignation" runat="server" Width="88px"></asp:TextBox>
                     </td>
                    
                </tr>
                
                <tr bgcolor="white">
                    <td align="left" class="field1" style="width: 300px; height: 22px;">
                        <font class="blackfnt">Purpose of Visit</font>
                    </td>
                    <td align="left" style="width: 138px; height: 22px;" colspan="4">
                         <asp:TextBox ID="txtPurposeofVisit" runat="server" width="430"></asp:TextBox></td>
                    </tr>
                    <tr bgcolor="white">
                    <td align="left" class="field1" style="width: 300px; height: 22px;">
                        <font class="blackfnt">Remarks</font>
                    </td>
                    <td align="left" style="width: 138px; height: 22px;" colspan="4">
                         <asp:TextBox ID="txtRemarks" runat="server" Height="56px" Width="200px" TextMode="MultiLine"></asp:TextBox>  
                     </td>
                </tr>
                
                
          </table>
          <br />
        <table align="center" cellspacing="1" cellpadding="1" width="85%" border="0">
        <tr bgcolor="white" align="center">
                    
                    <td style="width: 138px; height: 22px;" colspan="6">
                         <asp:Button ID="btnSubmit" runat="server" Height="24px" Text="Submit" Width="80px" style="left: 342px; position: relative; top: -1px" OnClick="btnSubmit_Click"/>
                    </td>
                </tr>
        </table>
        </div>
        </asp:Content>
