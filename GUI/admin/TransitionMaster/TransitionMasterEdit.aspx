<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="TransitionMasterEdit.aspx.cs" Inherits="GUI_admin_TransitionMaster_TransitionMaster"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript"> 

  function ch()
 {
//  
// 
//   var grid=document.getElementById("ctl00_MyCPH1_GV_D");
//  var rows=grid.rows.length;      // "ctl00$MyCPH1$GV_D"
//  var arrstr="";
//  
//  for(var b=4;b<rows+1;b++)
//  {
//    var c="";
//    var txt1="";
//    var txt2="";
//    
//    if(b<10)
//    {
//        c="ctl00_MyCPH1_GV_D_ctl0" + b + "_chksrno";
//        txt1="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtloc1";
//        txt2="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtloc2";
//        
//    }
//    else
//    {
//        c="ctl00_MyCPH1_GV_D_ctl" + b + "_chksrno";
//        txt1="ctl00_MyCPH1_GV_D_ctl" + b + "_txtloc1";
//        txt2="ctl00_MyCPH1_GV_D_ctl" + b + "_txtloc2";
//        
//    }
//    
// 
//   var tb1=document.getElementById(c);
//   var lc1=document.getElementById(txt1);
//   var lc2=document.getElementById(txt2);
//         
//    var q ="n"
//    
//        if(tb1.checked == true)
//        {
//             q="y"
//            
//             if(lc1.value=="" || lc2.value=="")
//             {
//                 alert("Please Enter Locations....")
//                return false;
//             
//             }
//          
//        return true;
//        }
//    else
//    {
//         continue
//    }
//    
//    }
//    
//    if(q == "n")
//    {
//    alert("Please Select Atleast One....")
//    return false;
// 
//    }
  
    }
    
     

function locBlur()
{
 
//chkCheck(loc);
  
 // var s="ctl00$MyCPH1$GV_D$ctl0";
  var grid=document.getElementById("ctl00_MyCPH1_GV_D");
  var rows=grid.rows.length;      // "ctl00$MyCPH1$GV_D"
  var arrstr="";
  for(var b=4;b<rows;b++)
  {
    var txt1="";
    var txt2="";
    if(b<10)
    {
        txt1="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtloc1";
        txt2="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtloc2";
    }
    else
    {
        txt1="ctl00_MyCPH1_GV_D_ctl" + b + "_txtloc1";
        txt2="ctl00_MyCPH1_GV_D_ctl" + b + "_txtloc2";
    }
     
     var tb1=document.getElementById(txt1);
     var tb2=document.getElementById(txt2);
     
     arrstr= arrstr + tb1.value + "," + tb2.value + "|";
     
     var arr2=arrstr.split("|");
        var l=arr2.length;
        
        for(var i=0;i<l-1;i++)  
            {
                for(var j=i+1;j<l-1;j++)
                {
                    if(arr2[i]==arr2[j])
                    {
                        alert("Duplicate Locations Found.....");
                      return false;
                    }
                }
            }
  
  }
   
  
}    
   
   function checklocation(obj)
        {
        var a;
        a=1;
        obj.value = obj.value.toUpperCase()
       for(i=0;i<str.length;i++)
       {

            if(obj.value==str[i])
            {
                a=2
                break;
                //return false;
            }
            else
            {
                continue
            }
       }
       if (a!=2)
       {
          alert("please enter valid location")
          obj.focus();
            return false;
       }

locBlur();
}


  function chkexist(obj)
        {
   
   debugger
     var a;
        a=1;
       
        obj.value  = obj.value.toUpperCase()
   
    var test1 = obj.value.substring((obj.value.length - 1),(obj.value.length))
   
    if(test1 == ",")
    {
       var s = obj.value.substring(0,(obj.value.length - 1))
       }
       else
    {
       var s = obj.value
       }
       
        
        var loc = s.split(",")
        
       
       
            for(j=0;j<loc.length;j++)
             {
                 
                for(i=0;i<loc.length;i++)
                {
                    if(loc[j].length > 2)
                    { 
                             if(loc[j] == loc[i])
                            {
                                a=2
                                break;
                                //return false;
                             }
                             else
                            {
                                continue
                            }
                    }
                  //  break
                }
       
      
       if (a!=2)
       {
        alert("Duplicate location : " +loc[j])
           
          return false;
      
       }
         
  }
 return true;
}   
     

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

    <div style="width: 9.5in">
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
                            <td height="30" align="left">
                                <a href=""><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a href=""><font
                                    class="blklnkund"><b>Administrator</b></font></a> <b>&gt; </b><a href=""><font class="blklnkund">
                                        <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Transition Master</b></font>
                            </td>
                        </tr>
                        <%--</table> 
                  </td> 
                </tr> --%>
                        <tr>
                            <td>
                                <%--<table border="0" cellpadding="1" cellspacing="1" class="boxbg"  align="center">
           
            <tr bgcolor="white">
               <td align="left" style="width: 91px; height: 40px;" ><font class="bluefnt">
                   Enter Row No *</font></td><td style="height: 40px" >
                   <asp:TextBox ID="roww" runat="server" Width="40px" BorderStyle="Groove" AutoPostBack="True" OnTextChanged="roww_TextChanged" TabIndex="25" ></asp:TextBox></td>
             </tr>
         </table>--%>
                                <asp:HiddenField ID="hifi" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <br />
                                <br />
                                <asp:UpdatePanel ID="upTable" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="GV_D" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey"
                                            PagerStyle-HorizontalAlign="left" CellPadding="5" CellSpacing="1" BorderWidth="0"
                                            ShowHeader="false" ShowFooter="false" OnRowCreated="row_hdr" EmptyDataText=" No Record Found"
                                            CssClass="boxbg" FooterStyle-CssClass="boxbg" AutoGenerateColumns="False" SelectedIndex="1">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" Width="70" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                                        </asp:Label><asp:CheckBox ID="chksrno" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                                    <%--  <HeaderTemplate>
                                                                                <asp:Label ID="Label1" runat="server"  CssClass="blackfnt" Text="Location" ></asp:Label>
                                                                                <asp:Label ID="loc_pop" runat="server" BorderStyle="Groove" Height="9px" Text='<a href="javascript:nwOpen(Label1.c)">...</a>'
                                                                                         Width="15px"></asp:Label>
                                                                                </HeaderTemplate>--%>
                                                    <ItemStyle CssClass="blackfnt" BackColor="white" Width="50" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtloc1" Width="60" Text='<%# DataBinder.Eval( Container.DataItem,"TRORGN") %>'
                                                            onblur="return checklocation(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <!---OnClick="nwOpen('ctl00_MyCPH1_GV_D_ctl03_txtloc1')" --->
                                                        <%-- <atlas:AutoCompleteExtender ID="Extender1" runat="server">
                                                        <atlas:AutoCompleteProperties Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetlocationList"
                                                            ServicePath="../../../GUI/services/location.asmx" TargetControlID="txtloc1" />
                                                    </atlas:AutoCompleteExtender>--%>
                                                        <ajaxToolkit:AutoCompleteExtender ID="Extender1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                                            ServiceMethod="GetlocationList" ServicePath="../../../GUI/services/location.asmx" TargetControlID="txtloc1">
                                                        </ajaxToolkit:AutoCompleteExtender>
                                                        <asp:TextBox ID="txtloc1_h" Width="60" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"TRORGN") %>'
                                                            runat="server"></asp:TextBox>
                                                        <%--<asp:Label ID="lblLocCod1" runat="server" BorderStyle="Groove" Height="9px" Text='<a href="javascript:nwOpen(5)">...</a>'
                                                                                         Width="15px"></asp:Label>--%>
                                                        <%--<asp:TextBox ID="txtddd" runat="server"   Visible="false" ></asp:TextBox>--%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                                    <%--<HeaderTemplate>
                                                                                <asp:Label ID="Label1" runat="server"  CssClass="blackfnt" Text="Location" ></asp:Label>
                                                                                <asp:Label ID="loc_pop" runat="server" BorderStyle="Groove" Height="9px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                                         Width="15px"></asp:Label>
                                                                                </HeaderTemplate>--%>
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" Width="50" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtloc2" Width="60" Text='<%# DataBinder.Eval( Container.DataItem,"TRDEST") %>'
                                                            onblur="return checklocation(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                      <%--  <atlas:autocompleteextender id="Extender2" runat="server">
                                                        <atlas:AutoCompleteProperties Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetlocationList"
                                                            ServicePath="../../../GUI/services/location.asmx" TargetControlID="txtloc2" />
                                                    </atlas:autocompleteextender>--%>
                                                     <ajaxToolkit:AutoCompleteExtender ID="Extender2" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                                ServiceMethod="GetlocationList" ServicePath="../../../GUI/services/location.asmx" TargetControlID="txtloc2">
                                            </ajaxToolkit:AutoCompleteExtender>
                                                        <asp:TextBox ID="txtloc2_h" Width="60" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"TRDEST") %>'
                                                            runat="server"></asp:TextBox>
                                                        <%--<asp:Label ID="lblLocCod1" runat="server" BorderStyle="Groove" Height="9px" Text='<a href="javascript:nwOpen(5)">...</a>'
                                                                                         Width="15px"></asp:Label>--%>
                                                        <%--<asp:TextBox ID="txtddd" runat="server"   Visible="false" ></asp:TextBox>--%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="RL_DAYS" Width="30" Text='<%# DataBinder.Eval( Container.DataItem,"trdays_Rail") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="RL_DAYS_h" Width="60" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"trdays_Rail") %>'
                                                            runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="RL_DIST" Width="30" Text='<%# DataBinder.Eval( Container.DataItem,"TRDIST_Rail") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="RL_DIST_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"TRDIST_Rail") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="RL_RATE1" Width="40" Text='<%# DataBinder.Eval( Container.DataItem,"STD_RATE_PER_KG_Rail") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="RL_RATE1_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"STD_RATE_PER_KG_Rail") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="RL_RATE2" Width="40" Text='<%# DataBinder.Eval( Container.DataItem,"STD_RATE_PER_PKG_Rail") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="RL_RATE2_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"STD_RATE_PER_PKG_Rail") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="RD_DAYS" Width="30" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="RD_DAYS_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"trdays") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="RD_DIST" Width="30" Text='<%# DataBinder.Eval( Container.DataItem,"TRDIST") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="RD_DIST_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"TRDIST") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="RD_RATE1" Width="40" Text='<%# DataBinder.Eval( Container.DataItem,"STD_RATE_PER_KG") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="RD_RATE1_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"STD_RATE_PER_KG") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="RD_RATE2" Width="40" Text='<%# DataBinder.Eval( Container.DataItem,"STD_RATE_PER_PKG") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="RD_RATE2_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"STD_RATE_PER_PKG") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle BackColor="white" HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="AIR_DAYS" Width="30" Text='<%# DataBinder.Eval( Container.DataItem,"trdays_Air") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="AIR_DAYS_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"trdays_Air") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="AIR_DIST" Width="30" Text='<%# DataBinder.Eval( Container.DataItem,"TRDIST_Air") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="AIR_DIST_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"TRDIST_Air") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="AIR_RATE1" Width="40" Text='<%# DataBinder.Eval( Container.DataItem,"STD_RATE_PER_KG_Air") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="AIR_RATE1_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"STD_RATE_PER_KG_Air") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="AIR_RATE2" Width="40" Text='<%# DataBinder.Eval( Container.DataItem,"STD_RATE_PER_PKG_Air") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="AIR_RATE2_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"STD_RATE_PER_PKG_Air") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="HSS_DAYS" Width="30" Text='<%# DataBinder.Eval( Container.DataItem,"trdays_exp") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="HSS_DAYS_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"trdays_exp") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="HSS_DIST" Width="30" Text='<%# DataBinder.Eval( Container.DataItem,"trdist_exp") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="HSS_DIST_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"trdist_exp") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="HSS_RATE1" Width="40" Text='<%# DataBinder.Eval( Container.DataItem,"std_rate_per_kg_exp") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="HSS_RATE1_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"std_rate_per_kg_exp") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="HSS_RATE2" Width="40" Text='<%# DataBinder.Eval( Container.DataItem,"std_rate_per_pkg_exp") %>'
                                                            onblur="return check(this)" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:TextBox ID="HSS_RATE2_h" Width="30" Visible="false" Text='<%# DataBinder.Eval( Container.DataItem,"std_rate_per_pkg_exp") %>'
                                                            runat="server" BorderStyle="Groove"></asp:TextBox>
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
    </div>
</asp:Content>
