(function(){$(document).on("ready page:load",function(){var e;return $(document).on("focus","input.datepicker:not(.hasDatepicker)",function(){var e,t,n;return e=$(this),"date"!==e[0].type?(t={dateFormat:"yy-mm-dd"},n=e.data("datepicker-options"),e.datepicker($.extend(t,n))):void 0}),$(".clear_filters_btn").click(function(){var e,t,n;return t=window.location.search.split("&"),n=/^(q\[|q%5B|q%5b|page|commit)/,window.location.search=function(){var i,a,o;for(o=[],i=0,a=t.length;a>i;i++)e=t[i],e.match(n)||o.push(e);return o}().join("&")}),$(".filter_form").submit(function(){return $(this).find(":input").filter(function(){return""===this.value}).prop("disabled",!0)}),$(".filter_form_field.select_and_search select").change(function(){return $(this).siblings("input").prop({name:"q["+this.value+"]"})}),$("#active_admin_content .tabs").tabs(),(e=$(".table_tools .batch_actions_selector")).length?e.next().css({width:"calc(100% - 10px - "+e.outerWidth()+"px)","float":"right"}):void 0})}).call(this);