<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ReAssignBalanceLocation.aspx.cs" Inherits="GUI_Operations_THC_Reassign_Location_ReAssignBalanceLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

    <script type="text/javascript" language="javascript" src="../../../../GUI/images/CalendarPopup.js"></script>
    <script type="text/javascript" language="javascript" src="../../../../GUI/images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" >
    var str_ba_fieldname=""
function validInt(event)
{
    if(event.keyCode==13)
    {
        return true;
    }
    if(event.keyCode<48 || event.keyCode>57)
    {
        event.keyCode=0;return false;
    }
}
function BaBlur(id)
{

}
var doc = null; 
var MyDiv = document.getElementById("ReportingToCombo");
	var formObj = null;
function createXMLHTTPObject()
	{
	    if (window.XMLHttpRequest) { // Mozilla, Safari,...
	        doc = new XMLHttpRequest();
	        if (doc.overrideMimeType) 
	        {
	            doc.overrideMimeType('text/xml');
	        }
	    } else if (window.ActiveXObject) { // IE
	        try {
	            doc = new ActiveXObject("Msxml2.XMLHTTP");
	        } catch (e) {
	            try {
	                doc = new ActiveXObject("Microsoft.XMLHTTP");
	            } catch (e) {}
	        }
	    }
	}
	var txt
function Dockblur(obj)
{
    txt=document.getElementById(obj);
    str_ba_fieldname=obj.replace("txtdocno","txtexbacode")
    str_hdnfld=obj.replace("txtdocno","hdnfld")
    if(txt.value=="")
        return false;
    txt.value=txt.value.toUpperCase();
    var findobj=false;
    
    createXMLHTTPObject();
    if(doc)
    {
         var strpg="CheckExist.aspx?mode=docket&dockno=" + txt.value + "&sid=" + Math.random();
         doc.onreadystatechange = doWork; 
		 doc.open("GET",strpg, false);
		 doc.send(null);
    }
}
    function doWork() 
    {
	    if (doc.readyState == 4) 
	    {
	    //debugger
	        val=doc.responseText
	        var res=doc.responseText.split("|");
	        //alert(doc.responseText);
			if(res[0]=="false")
            {
                    alert(res[1]);
                    txt.value="";
                    return false;
            }
            else
            {
                    document.getElementById(str_ba_fieldname).value=res[1];
                    document.getElementById(str_hdnfld).value=res[1];
            }
				
	    }
	}	

function validateBoxes()
{
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   var non=0;
   for(var i=2;i<=r;i++)
   {    
        var txtbacode,txtdocno;
        if(i<10)
            {
                txtdocno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtdocno");
                txtbacode=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtbacode");
            }
        else
            {
                txtdocno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtdocno");
                txtbacode=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtbacode");
            }
            
            if(txtdocno.value!="")
                {
                    non=1;
                    if(txtbacode.value=="")
                    {
                        alert("Plz Enter New Balance Location Code .....");
                        txtbacode.focus();
                        return false;
                    }
                   
                }
    } /// end for
    if(non==0)
    {
        alert("Please Enter THC Number for Update Location.........");
        return false;
    }
}

function popuplist(mode,ctlid,tbl)
{
    var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
    var url="";
    url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
    confirmWin=window.open(url,"",winOpts);
}


function addRows()
{
    //debugger;
    var txt = document.getElementById("ctl00_MyCPH1_txtnorows");
    if(txt.value == "")
      {
        alert("Enter No of rows Proprly.....");
        txt.focus();
        return false;
      }  
    if(confirm("The Entered Data will be Removed. Are you want to continue...?"))
        return true;
    else
        return false;
}
    </script>
  <div align="left" style="width: 10in;">
    <table border="0" cellpadding="0" class="boxbg" cellspacing="0">
        <tr bgcolor="white">
            <td align="left" colspan="5" height="30" style="width: 459px">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                <b>Operations</b></font></a> <b>&gt; </b><a href=""><font class="blklnkund">
                <b>Re-Assign THC Balance Location</b></font></a> <b>&gt;</b>
            </td>
        </tr>
    </table>
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="100%">
        <tr class="bgbluegrey">
            <td class="blackfnt" align="center">
                <b>Re-Assign THC Balance Location</b>
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                    width="100%">
                    <tr bgcolor="#ffffff">
                        <td class="blackfnt" align="right" width="50%">
                            Enter No. of Rows </td>
                        <td class="blackfnt" align="left" width="50%">
                            <asp:TextBox runat="server" ID="txtnorows" Width="40px" style="text-align:right;" BorderStyle="Groove" MaxLength="2" onkeypress="javascript:return validInt(event)"></asp:TextBox>
                            <asp:Button runat="server" Text="Add Rows" CssClass="blackfnt" OnClick="btnrows_Click" ID="btnrows" />
                        </td>
                    </tr>
                </table>
                <br />
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                            <tr>
                                <td align="right"><img src="../../../images/loading.gif"alt="" /></td>
                                <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
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
                <br />
                <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                    width="100%">
                    <tr bgcolor="#ffffff">
                        <td class="blackfnt" align="left">
                            <asp:GridView CssClass="boxbg" runat="server" CellSpacing="1" BorderWidth="0" ID="grvcontrols"
                                Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                                OnRowDataBound="grvcontrols_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr. No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="THC Number">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" BorderStyle="Groove" MaxLength="25" Width="100px" ID="txtdocno"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Existing Balance LocCode">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtexbacode" BorderStyle="Groove" Enabled="false" MaxLength="5" Width="60px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            New Balance Location <br />
                                              <asp:TextBox runat="server" ID="txtnewbacode" BorderStyle="Groove" MaxLength="15" Width="60px"></asp:TextBox>
                                            <asp:Button ID="btnnewbacode" Text="..." CssClass="blackfnt" runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtbacode" BorderStyle="Groove" MaxLength="50" Width="60px" runat="server"></asp:TextBox>
                                            <asp:Button ID="btnbacode" Text="..." CssClass="blackfnt" runat="server" />
                                            <asp:HiddenField ID="hdnfld" runat="server" /> 
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td class="blackfnt" align="center">
                            <asp:Button runat="server" OnClick="btnsubmit_Click" Text="Submit" CssClass="blackfnt"
                                ID="btnsubmit"></asp:Button>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
       </div> 
    <asp:HiddenField ID="hdnrows" runat="server" Value="5" />
    <asp:HiddenField ID="hidden_val_name" runat="server" Value="" />
</asp:Content>

