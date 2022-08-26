<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="StateMasterEditsan.aspx.cs" Inherits="GUI_admin_TransitionMaster_TransitionMaster"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript"> 


function chchg(obj1,obj2,obj3)
{ 
 // debugger
 
//   var grid=document.getElementById("ctl00_MyCPH1_GV_D");
//  var rows=grid.rows.length;      // "ctl00$MyCPH1$GV_D"
//  var arrstr="";
//  for(var b=2;b<rows;b++)
//  {
//  
//    var c2="";
//    var t=""
//    
//    if(b<10)
//    {
// 
//        c2="ctl00_MyCPH1_GV_D_ctl0" + b + "_actch";
//        t="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtch";
//        
//    }
//    else
//    {
//   
//        c2="ctl00_MyCPH1_GV_D_ctl" + b + "_actch";
//        t="ctl00_MyCPH1_GV_D_ctl" + b + "_txtch";
//        
//    }
//    
// 
// 
//var tb2=document.getElementById(c2);
//var tb3=document.getElementById(t);

 if(obj1.checked == true)
    {
        obj2.value="Y";
        obj3.value="Y";
    
    }
    else
    {
      obj2.value="N";
      obj3.value="Y";
    }
 
    return true;
 
}

function ch()
{
 
  
  var grid=document.getElementById("ctl00_MyCPH1_GV_D");
  var rows=grid.rows.length;      // "ctl00$MyCPH1$GV_D"
  var arrstr="";
  var q ="n";
   
 
  for(var b=2;b<=rows;b++)
  {
        var c="";
        var c2="";
        var t="";
        var t2="";
        var d="";
        
        if(b<10)
        {
            c="ctl00_MyCPH1_GV_D_ctl0" + b + "_chksrno";
            c2="ctl00_MyCPH1_GV_D_ctl0" + b + "_actch";
            t="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtch";
            
             t2="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtdoc";
            d="ctl00_MyCPH1_GV_D_ctl0" + b + "_ddlbound";
            
        }
        else
        {
            c="ctl00_MyCPH1_GV_D_ctl" + b + "_chksrno";
            c2="ctl00_MyCPH1_GV_D_ctl" + b + "_actch";
            t="ctl00_MyCPH1_GV_D_ctl" + b + "_txtch";
            
             t2="ctl00_MyCPH1_GV_D_ctl" + b + "_txtdoc";
            d="ctl00_MyCPH1_GV_D_ctl" + b + "_ddlbound";
            
        }
        
 
        var tb1=document.getElementById(c);
        var tb2=document.getElementById(c2);
        var tb3=document.getElementById(t);
        
        var tb4=document.getElementById(t2);
        var tb5=document.getElementById(d);
        
 
 
      if(tb1.checked == true)
        {
            q="y"
           
            if(tb4.value=="")
            {
                alert("Document Name Can not ne Blanck....")
                tb4.focus();
                return false;
            }
 
            if(tb5.value=="N")
            {
                alert("Please Select I/O Bound")
                tb5.focus();
                return false;
                
            }
            
              
            
            //return true;
        }
         
        

   } // END OF for

       if(q == "n")
        {
            alert("Please Select Atleast One....")
            return false;
        }
   
     return true;
 
} // END OF ch
    
    
    
         
 
    function IsNumericWoDot(sText)
    {
       var ValidChars = "0123456789";
       var IsNumber=true;
       var Char;

       for (i = 0; i < sText.length && IsNumber == true; i++) 
       { 
          Char = sText.charAt(i); 
          
          if (ValidChars.indexOf(Char) == -1) 
          {
            IsNumber = false;
          }
       }
       
       return IsNumber;
    }

     function nwOpen(mNo)
        {
        //debugger
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        
 function check(obj)
{
  
  if(obj.value=="")
{
    alert("Please Enter Value")
   obj.focus();
    return false
}
if(isNaN(obj.value))
{
    alert("Please Enter Only Numeric Value")
     obj.focus();
    return false
}
if(obj.value<0)
{
    alert("Please Enter Positive Value")
   obj.focus();
    return false
}
}
    
     
    
    
            
     
      
    </script>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
        <tr>
            <td>
                <font class="blackfnt"><a href=""><b><u>Module </u></b></a>&gt; <a href="../../welcome.aspx">
                    <b><u>Administrator </u></b></a>&gt; <a href="../company_structure.aspx"><b><u>Company
                        Structure </u></b></a>&gt; <b><u>State Master </u></b></font>
                <td>
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../images/back.gif" border="0" alt="" /></a>
                </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                        <td>
                            <center>
                                <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="60%">
                                    <tr class="bgbluegrey">
                                        <td align="center" colspan="4">
                                            <font class="blackfnt"><b>State Master Header</b></font>
                                        </td>
                                    </tr>
                                    <tr bgcolor="#ffffff">
                                        <td align="center">
                                            <font class="blackfnt">State Code :</font>
                                        </td>
                                        <td align="center">
                                            <font class="blackfnt" color="#FF0000">
                                                <asp:Label ID="lbstcd" runat="server" Text="System Generated"></asp:Label></font>
                                            <%--<asp:Label ID="lblStCd" runat="server"></asp:Label>--%>
                                        </td>
                                        <td align="center">
                                            <font class="blackfnt">State Name :</font>
                                        </td>
                                        <td align="center">
                                            <asp:UpdatePanel ID="upState" runat="server">
                                                <ContentTemplate>
                                                    <asp:TextBox ID="txtStateName" runat="server" CssClass="input" AutoPostBack="true"></asp:TextBox>
                                                  <%--  <atlas:autocompleteextender id="Extender1" runat="server">
<atlas:AutoCompleteProperties Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetStateList"
ServicePath="../../../GUI/services/WebService.asmx" TargetControlID="txtStateName" /></atlas:autocompleteextender>--%>
                                                    <ajaxToolkit:AutoCompleteExtender ID="Extender1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                                        ServiceMethod="GetStateList" ServicePath="../../../GUI/services/WebService.asmx" TargetControlID="txtStateName">
                                                    </ajaxToolkit:AutoCompleteExtender>
                                                    <label class="blackfnt" id="lblErrorState" runat="server" style="color: Red;" visible="false">
                                                        Invalid State!!!
                                                    </label>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="txtStateName" EventName="TextChanged" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <br />
                            <asp:UpdatePanel ID="upTable" runat="server">
                                <ContentTemplate>
                                    <%--                 <asp:GridView ID="GV_D" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                        OnDataBound ="getdata"
                                                       BackColor="white"
                                                EmptyDataText=" No Record Found"
                                                             CssClass="boxbg" FooterStyle-CssClass="boxbg" 
                                                            AutoGenerateColumns="False" SelectedIndex="1">
                                                             --%>
                                    <asp:GridView ID="GV_D" runat="server" align="center" BorderWidth="1" CellPadding="2"
                                        HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                        BackColor="white" FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                                        AllowSorting="False" AutoGenerateColumns="false" OnRowDataBound="getdata" EmptyDataText="No Records Found...">
                                        <PagerStyle VerticalAlign="Bottom" />
                                        <Columns>
                                            <asp:TemplateField HeaderStyle-Font-Bold="true" HeaderText="Sr. No.">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                                <ItemStyle CssClass="blackfnt" Width="50" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                                    </asp:Label>
                                                    <asp:CheckBox ID="chksrno" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Font-Bold="true" HeaderText="Document Name">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                                <%--  <HeaderTemplate>
                                                                                <asp:Label ID="Label1" runat="server"  CssClass="blackfnt" Text="Location" ></asp:Label>
                                                                                <asp:Label ID="loc_pop" runat="server" BorderStyle="Groove" Height="9px" Text='<a href="javascript:nwOpen(Label1.c)">...</a>'
                                                                                         Width="15px"></asp:Label>
                                                                                </HeaderTemplate>--%>
                                                <ItemStyle CssClass="blackfnt" Width="160" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtdoc" Width="150" Text='<%# DataBinder.Eval( Container.DataItem,"stform") %>'
                                                        runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    <!---OnClick="nwOpen('ctl00_MyCPH1_GV_D_ctl03_txtloc1')" --->
                                                    <asp:TextBox ID="txtdoc_h" Width="60" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"stform") %>'
                                                        runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Font-Bold="true" HeaderText="In-Bound / Out-Bound">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                                <ItemStyle CssClass="blackfnt" Width="150" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="d_h" Width="60" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"inoutbound") %>'
                                                        runat="server"></asp:TextBox>
                                                    <asp:DropDownList ID="ddlbound" Width="140" runat="server">
                                                        <asp:ListItem Text="Select" Value="N"></asp:ListItem>
                                                        <asp:ListItem Text="In-Bound" Value="I"></asp:ListItem>
                                                        <asp:ListItem Text="Out-Bound" Value="O"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderStyle-Font-Bold="true" HeaderText="Active">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                                <ItemStyle CssClass="blackfnt" Width="80" />
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="actch" runat="server" Checked="true" />
                                                    <asp:TextBox ID="txtch" Width="40" Text='<%# DataBinder.Eval( Container.DataItem,"activeflag") %>'
                                                        Enabled="false" MaxLength="1" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    <asp:HiddenField ID="h1" Value="Y" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle CssClass="bgbluegrey" />
                                        <HeaderStyle CssClass="bgbluegrey" />
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <%--</td> 
                   </tr>
				 </table> --%>
                </table>
            </td>
        </tr>
        <tr>
            <td align="center">
                <center>
                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
                </center>
            </td>
        </tr>
    </table>
</asp:Content>
