<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="LoadingSundryCharges.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_LoadingSundry" %>

<asp:Content ContentPlaceHolderID="MyCPH1" runat="server" ID="cntone">

    <script type="text/javascript" language="javascript">

function submitClick()
{   
    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
    if(hdnajaxstate.value!="0")
    {
        alert("Let the Internal processes over. Try after 5-10 seconds later.");
        return false;
    }
    var reccount=0;
    var gridbranch=document.getElementById("ctl00_MyCPH1_grvbranch");
    var lenbranch=gridbranch.rows.length;
    var pref="";
    for(var i=2;i<lenbranch+1;i++)
    {
        
        if(i<10)
            pref="ctl00_MyCPH1_grvbranch_ctl0" + i + "_";
        else
            pref="ctl00_MyCPH1_grvbranch_ctl" + i + "_";
            
        var chkyes=document.getElementById(pref + "chkyes");
        if(chkyes.checked==true)
        {
            var txtlocation=document.getElementById(pref + "txtlocation");
         
            var txtairrate=document.getElementById(pref + "txtairrate");
            var txtroadrate=document.getElementById(pref + "txtroadrate");
            var txttrainrate=document.getElementById(pref + "txttrainrate");
            var txtexpressrate=document.getElementById(pref + "txtexpressrate");
          
            reccount=1;
            if(txtlocation.value=="")
            {
                 alert("Please Enter Location");
                 txtlocation.focus();
                 return false;
             }    
             
            
            if(txtairrate.value=="")
                txtairrate.value="0.00";
                
            if(txtroadrate.value=="")
                txtroadrate.value="0.00";

            if(txttrainrate.value=="")
                txttrainrate.value="0.00";
                
            if(txtexpressrate.value=="")
                txtexpressrate.value="0.00";
                
                
                var Jpref="";
                for(var j=2;j<lenbranch+1;j++)
                {
                    if(j<10)
                        Jpref="ctl00_MyCPH1_grvbranch_ctl0" + j + "_";
                    else
                        Jpref="ctl00_MyCPH1_grvbranch_ctl" + j + "_";
            
                    var chkJyes=document.getElementById(Jpref + "chkyes");
                    var txtJbranch=document.getElementById(Jpref + "txtlocation");
                
                               
                     
                     if(i!=j)
                     {
                         
                            if(txtlocation.value==txtJbranch.value)
                            {
                                alert("Duplicate record Found....");
                                txtlocation.focus();
                                return false;
                            }
                        
                     }
                }
        }
    }


    var gridcity=document.getElementById("ctl00_MyCPH1_grvcity");
    var lencity=gridcity.rows.length;
    var pref="";
    for(var i=2;i<lencity+1;i++)
    {
        
        if(i<10)
            pref="ctl00_MyCPH1_grvcity_ctl0" + i + "_";
        else
            pref="ctl00_MyCPH1_grvcity_ctl" + i + "_";
            
        var chkyes=document.getElementById(pref + "chkyes");
        if(chkyes.checked==true)
        {
            var txtlocation=document.getElementById(pref + "txtlocation");
            var txtairrate=document.getElementById(pref + "txtairrate");
            var txtroadrate=document.getElementById(pref + "txtroadrate");
            var txttrainrate=document.getElementById(pref + "txttrainrate");
            var txtexpressrate=document.getElementById(pref + "txtexpressrate");
            reccount=1;
            
            if(txtlocation.value=="")
            {
                 alert("Please Enter Location");
                 txtlocation.focus();
                 return false;
             }    
             
            
  
            if(txtairrate.value=="")
                txtairrate.value="0.00";
                
            if(txtroadrate.value=="")
                txtroadrate.value="0.00";

            if(txttrainrate.value=="")
                txttrainrate.value="0.00";
                
            if(txtexpressrate.value=="")
                txtexpressrate.value="0.00";
                
                
                var Jpref="";
                for(var j=2;j<lencity+1;j++)
                {
                    if(j<10)
                        Jpref="ctl00_MyCPH1_grvcity_ctl0" + j + "_";
                    else
                        Jpref="ctl00_MyCPH1_grvcity_ctl" + j + "_";
            
                    var chkJyes=document.getElementById(Jpref + "chkyes");
                    var txtJcity=document.getElementById(Jpref + "txtlocation");
                    
                     
                     if(i!=j)
                     {
                         
                            if(txtlocation.value==txtJcity.value)
                            {
                                alert("Duplicate record Found....");
                                txtlocation.focus();
                                return false;
                            }
                        
                     }
                }
        }
    }

    if(reccount==0)
    {
        alert("No Record Selected....");
        return false;
    }
    
    
      var cmbratetype=document.getElementById("ctl00_MyCPH1_cmbratetype");
      if(cmbratetype.value=="" || cmbratetype.value=="0")
      {
        alert("Please Select Rate Type..");
        cmbratetype.focus();
        return false;
      }
      
      
  
    var btnsubmit=document.getElementById("ctl00_MyCPH1_btnsubmit");
    btnsubmit.style.display="none";
    return true;
}
// USED TO ENTER BRANCH,LOCATION OR ZONE VIA POPUP
function popuplist(mode,ctlid,tbl)
 { 
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=0";
            confirmWin=window.open(url,"",winOpts);
            return false;
 }

// this function assignment in keypress doesn't allow any character other than number.
function noEnter(event)
{
    if(event.keyCode==13)
        {
            return false;
        }
    if(event.keyCode<48 || event.keyCode>57)
    {
        event.keyCode=0;return false;
    }
}



// Inner Function to Ropund upto defined decimal places, returns string
	function roundNumber(num, dec) 
	{
	    if(num=="." || num==".0" || num=="0" || num=="0." || num=="" || !num)
	        return "0.00";
	     
	    var result = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec);
	           
        var len=0;
        var number=result.toString();
        len=number.length;
        
        if(number=="." || number==".0" || number=="0" || number=="0." || num=="" || !num)
	        return "0.00";
	        
        if(number.indexOf('.') == parseInt(len - 2) && len>=2)
        {
            number=number + "0";
        }
        else if(number.indexOf('.') == parseInt(len - 1))
        {
            number = number + "00";
        }
        else if(number.indexOf('.')== -1)
        {
            number = number + ".00";
        }
        
        	return number;    
    }
    
function locTest(id)
{
    var txtloc=document.getElementById(id);
    txtloc.value=txtloc.value.toUpperCase();

    if(txtloc.value=="")
        return false;

    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
    hdnajaxstate.value="1";

    var ajaxobj=false;
    ajaxobj=GetXMLHttpObject();
    if(ajaxobj)
    {
     var strpg="AjaxResponse.aspx?mode=check&code1=loctest&code2=" + txtloc.value + "&sid=" + Math.random() + "&sid=" + Math.random();
     ajaxobj.open("GET",strpg);
     ajaxobj.onreadystatechange=function()
         {
             if((ajaxobj.readyState==4) && (ajaxobj.status==200))
                {
                  var  res=ajaxobj.responseText.split("|");
                  
                  if(res[0]=="false")
                     {
                        alert(txtloc.value + " Locaton doesn't Exists");
                        txtloc.value="";
                        txtloc.focus();
                        hdnajaxstate.value="0";
                        return false;
                     }
                  else
                        hdnajaxstate.value="0";
                }
         }
         
    ajaxobj.send(null);
    }
    
return false;
}
	
function cityTest(id)
{
    var txtloc=document.getElementById(id);
    txtloc.value=txtloc.value.toUpperCase();

    if(txtloc.value=="")
        return false;

    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
    hdnajaxstate.value="1";

    var ajaxobj=false;
    ajaxobj=GetXMLHttpObject();
    if(ajaxobj)
    {
     var strpg="AjaxResponse.aspx?mode=check&code1=citytest&code2=" + txtloc.value + "&sid=" + Math.random() + "&sid=" + Math.random();
     ajaxobj.open("GET",strpg);
     ajaxobj.onreadystatechange=function()
         {
             if((ajaxobj.readyState==4) && (ajaxobj.status==200))
                {
                  var  res=ajaxobj.responseText.split("|");
                  
                  if(res[0]=="false")
                     {
                        alert(txtloc.value + " City doesn't Exists");
                        txtloc.value="";
                        txtloc.focus();
                        hdnajaxstate.value="0";
                        return false;
                     }
                  else
                        hdnajaxstate.value="0";
                }
         }
         
    ajaxobj.send(null);
    }
    
return false;
}	
	
    </script>

    <script src="../../images/commonJs.js" type="text/javascript" language="javascript"></script>

    <br />
    <br />
   <asp:Table ID="Table1" runat="server" CssClass="blackfnt" >
             <asp:TableRow BackColor="White">
                <asp:TableCell>
				       &nbsp;ContractID  
                </asp:TableCell>
                <asp:TableCell>
                     : <asp:Label ID="lblcontractid" runat="server" onmouseover="this.style.cursor='pointer'" CssClass="redfnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
                         <asp:TableRow BackColor="White">
                <asp:TableCell>
				       &nbsp;Customer Code & Name &nbsp;
                </asp:TableCell>
                <asp:TableCell>
                : <asp:Label ID="lblcustcodename" runat="server" onmouseover="this.style.cursor='pointer'" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table> 
        <br />
    <asp:Panel runat="server" Width="10in">
        <asp:Table runat="server" Width="100%" CssClass="blackfnt">
            <asp:TableRow>
                <asp:TableCell Width="50%" HorizontalAlign="Right" Font-Bold="true">Rate Type :<br /><br /></asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                    <asp:DropDownList ID="cmbratetype" runat="server" BackColor="white" CssClass="blackfnt">
                        <asp:ListItem Value="0">Select</asp:ListItem>
                        <asp:ListItem Value="W">Per Kg.</asp:ListItem>
                        <asp:ListItem Value="P">Per Package</asp:ListItem>
                        <asp:ListItem Value="T" Text="Per Ton"></asp:ListItem>
                    </asp:DropDownList><br /><br />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ColumnSpan="2">
                    <asp:UpdatePanel ID="upd1" runat="server">
                        <ContentTemplate>
                            <asp:Table runat="server" Width="100%" CssClass="boxbg" CellSpacing="1" CellPadding="0">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell HorizontalAlign="Center" ColumnSpan="2" Font-Bold="true">Loading Charges Sundry - Branch</asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow BackColor="White">
                                    <asp:TableCell HorizontalAlign="Right" Width="50%">
                                    No of Rows :                
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtbranchnorows" Width="50px" BorderStyle="groove" Style="text-align: right;"
                                            onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                                        <asp:Button ID="btnbranchnorows" CssClass="blackfnt" Text="Add Rows" OnClick="btnbranchnorows_Click"
                                            runat="server" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow BackColor="White">
                                    <asp:TableCell ColumnSpan="2">
                                        <asp:GridView CssClass="boxbg" runat="server" ID="grvbranch" CellSpacing="1" Width="99.8%"
                                            AllowSorting="true" PagerStyle-HorizontalAlign="left" BorderWidth="0" FooterStyle-CssClass="boxbg"
                                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                                            PagerSettings-LastPageText="[Last]" Style="margin: 1px 1px 1px 1px;" OnRowDataBound="grvbranch_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkyes" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Branch
                                                        <input type="button" id="btnheadbranch" runat="server" onclick="javascript:return popuplist('branch','txtlocation','grvbranch')"
                                                            class="blackfnt" value="..." />
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtlocation" Text='<%# DataBinder.Eval( Container.DataItem,"location") %>'
                                                            onblur="javascript:return locTest(this.getAttribute('id'))" BorderStyle="groove"
                                                            Width="50px" runat="server"></asp:TextBox>
                                                        <input type="button" id="btnlocation" onclick="javascript:return popuplist('branch','ctl00_MyCPH1_txtlocation','none')"
                                                            runat="server" class="blackfnt" value="..." />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Air
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtairrate" Text='<%# DataBinder.Eval( Container.DataItem,"airrate") %>'
                                                            BorderStyle="groove" Style="text-align: right;" onblur="javascript:return this.value=roundNumber(this.value,2)"
                                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="80px"
                                                            runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Road
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtroadrate" Text='<%# DataBinder.Eval( Container.DataItem,"roadrate") %>'
                                                            onblur="javascript:return this.value=roundNumber(this.value,2)" BorderStyle="groove"
                                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                            Width="80px" runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Train
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txttrainrate" Text='<%# DataBinder.Eval( Container.DataItem,"trainrate") %>'
                                                            onblur="javascript:return this.value=roundNumber(this.value,2)" BorderStyle="groove"
                                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                            Width="80px" runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Express
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtexpressrate" Text='<%# DataBinder.Eval( Container.DataItem,"expressrate") %>'
                                                            onblur="javascript:return this.value=roundNumber(this.value,2)" BorderStyle="groove"
                                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                            Width="80px" runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ColumnSpan="2">
                    <br />
                    <br />
                    <asp:UpdatePanel ID="upd2" runat="server">
                        <ContentTemplate>
                            <asp:Table runat="server" Width="100%" CssClass="boxbg" CellSpacing="1" CellPadding="0">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell HorizontalAlign="Center" ColumnSpan="2" Font-Bold="true">Loading Charges Sundry - City</asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow BackColor="White">
                                    <asp:TableCell HorizontalAlign="Right" Width="50%">
                    No of Rows :                
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtcitynorows" Width="50px" BorderStyle="groove" Style="text-align: right;"
                                            onkeypress="javascript:return noEnter(event)" runat="server"></asp:TextBox>
                                        <asp:Button ID="btncitynorows" CssClass="blackfnt" Text="Add Rows" OnClick="btncitynorows_Click"
                                            runat="server" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow BackColor="White">
                                    <asp:TableCell ColumnSpan="2">
                                        <asp:GridView CssClass="boxbg" runat="server" ID="grvcity" CellSpacing="1" Width="99.8%"
                                            AllowSorting="true" PagerStyle-HorizontalAlign="left" BorderWidth="0" FooterStyle-CssClass="boxbg"
                                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                                            PagerSettings-LastPageText="[Last]" Style="margin: 1px 1px 1px 1px;" OnRowDataBound="grvcity_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkyes" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        City
                                                        <asp:Button ID="btnheadfrom" OnClientClick="javascript:return popuplist('city','txtlocation','grvcity')"
                                                            Text="...." runat="server" />
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtlocation" Text='<%# DataBinder.Eval( Container.DataItem,"location") %>'
                                                            onblur="javascript:return cityTest(this.getAttribute('id'))" BorderStyle="groove"
                                                            Width="100px" runat="server"></asp:TextBox>
                                                        <input type="button" id="btnlocation" runat="server" onclick="javascript:return popuplist('city','ctl00_MyCPH1_txtlocation','none')"
                                                            class="blackfnt" value="..." />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Air
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtairrate" Text='<%# DataBinder.Eval( Container.DataItem,"airrate") %>'
                                                            onblur="javascript:return this.value=roundNumber(this.value,2)" BorderStyle="groove"
                                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                            Width="80px" runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Road
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtroadrate" Text='<%# DataBinder.Eval( Container.DataItem,"roadrate") %>'
                                                            onblur="javascript:return this.value=roundNumber(this.value,2)" BorderStyle="groove"
                                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                            Width="80px" runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Train
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txttrainrate" Text='<%# DataBinder.Eval( Container.DataItem,"trainrate") %>'
                                                            onblur="javascript:return this.value=roundNumber(this.value,2)" BorderStyle="groove"
                                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                            Width="80px" runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                                    <HeaderTemplate>
                                                        Express
                                                    </HeaderTemplate>
                                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtexpressrate" Text='<%# DataBinder.Eval( Container.DataItem,"expressrate") %>'
                                                            onblur="javascript:return this.value=roundNumber(this.value,2)" BorderStyle="groove"
                                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                            Width="80px" runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                    <asp:UpdateProgress ID="uppMain" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%;
                            left: 40%;" width="190px" cellpadding="0"
                        bgcolor="white">
                        <tr>
                            <td align="right">
                                <img src="../../images/loading.gif" alt="" />
                            </td>
                            <td>
                                <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                        width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                        runat="server">
                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                            left: 50%;" ID="Panel2" runat="server">
                        </asp:Panel>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                    <br />
                    <asp:Table runat="server" BorderWidth="0" Width="100%" CellPadding="0" CellSpacing="1"
                        CssClass="boxbg">
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell>
                                <asp:Button ID="btnsubmit" OnClick="btnsubmit_Click" runat="server" CssClass="blackfnt"
                                    OnClientClick="javascript:return submitClick()" Text="Submit" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
        <asp:HiddenField ID="hdnclient" runat="server" Value="0" />
    </asp:Panel>
</asp:Content>
