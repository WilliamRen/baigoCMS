{* tag_list.tpl 标签列表 *}
{$cfg = [
	title          => "{$adminMod.article.main.title} - {$adminMod.article.sub.tag.title}",
	menu_active    => "article",
	sub_active     => "tag",
	baigoCheckall  => "true",
	baigoValidator => "true",
	baigoSubmit    => "true",
	str_url        => "{$smarty.const.BG_URL_ADMIN}ctl.php?mod=tag&{$tplData.query}"
]}

{include "include/admin_head.tpl"}

	<li><a href="{$smarty.const.BG_URL_ADMIN}ctl.php?mod=article&act_get=list">{$adminMod.article.main.title}</a></li>
	<li>{$adminMod.article.sub.tag.title}</li>

	{include "include/admin_left.tpl" cfg=$cfg}

	<div class="form-group">
		<div class="pull-left">
			<ul class="list-inline">
				<li>
					<a href="{$smarty.const.BG_URL_ADMIN}ctl.php?mod=tag&act_get=list">
						<span class="glyphicon glyphicon-plus"></span>
						{$lang.href.add}
					</a>
				</li>
				<li>
					<a href="{$smarty.const.BG_URL_HELP}?lang=zh_CN&mod=help&act=tag_mark" target="_blank">
						<span class="glyphicon glyphicon-question-sign"></span>
						{$lang.href.help}
					</a>
				</li>
			</ul>
		</div>
		<div class="pull-right">
			<form name="tag_search" id="tag_search" action="{$smarty.const.BG_URL_ADMIN}ctl.php" method="get" class="form-inline">
				<input type="hidden" name="mod" value="tag">
				<input type="hidden" name="act_get" value="list">
				<select name="status" class="form-control input-sm">
					<option value="">{$lang.option.allStatus}</option>
					{foreach $status.tag as $key=>$value}
						<option {if $tplData.search.status == $key}selected{/if} value="{$key}">{$value}</option>
					{/foreach}
				</select>
				<input type="text" name="key" value="{$tplData.search.key}" placeholder="{$lang.label.key}" class="form-control input-sm">
				<button type="submit" class="btn btn-default btn-sm">{$lang.btn.filter}</button>
			</form>
		</div>
		<div class="clearfix"></div>
	</div>

	<div class="row">
		<div class="col-md-3">
			<div class="well">
				<form name="tag_form" id="tag_form">
					<input type="hidden" name="token_session" class="token_session" value="{$common.token_session}">
					<input type="hidden" name="tag_id" value="{$tplData.tagRow.tag_id}">
					<input type="hidden" name="act_post" value="submit">
					{if $tplData.tagRow.tag_id > 0}
						<div class="form-group">
							<label class="control-label">{$lang.label.id}</label>
							<p class="form-control-static">{$tplData.tagRow.tag_id}</p>
						</div>
					{/if}

					<div class="form-group">
						<label form="tag_name" class="control-label">{$lang.label.tagName}<span id="msg_tag_name">*</span></label>
						<input type="text" value="{$tplData.tagRow.tag_name}" name="tag_name" id="tag_name" class="validate form-control">
					</div>

					<label class="control-label">{$lang.label.status}<span id="msg_tag_status">*</span></label>
					<div class="form-group">
						{foreach $status.tag as $key=>$value}
							<label for="tag_status_{$key}" class="radio-inline">
								<input type="radio" name="tag_status" id="tag_status_{$key}" {if $tplData.tagRow.tag_status == $key}checked{/if} value="{$key}" class="validate" group="tag_status">
								{$value}
							</label>
						{/foreach}
					</div>

					<div class="form-group">
						<button type="button" id="tag_add" class="btn btn-primary">{$lang.btn.save}</button>
					</div>
				</form>
			</div>
		</div>

		<div class="col-md-9">
			<form name="tag_list" id="tag_list" class="form-inline">
				<input type="hidden" name="token_session" class="token_session" value="{$common.token_session}">

				<div class="panel panel-default">
					<div class="table-responsive">
						<table class="table table-striped table-hover">
							<thead>
								<tr>
									<th class="td_mn">
										<label for="chk_all" class="checkbox-inline">
											<input type="checkbox" name="chk_all" id="chk_all" class="first">
											{$lang.label.all}
										</label>
									</th>
									<th class="td_mn">{$lang.label.id}</th>
									<th>{$lang.label.tagName}</th>
									<th class="td_sm">{$lang.label.status}</th>
									<th class="td_sm">{$lang.label.articleCount}</th>
								</tr>
							</thead>
							<tbody>
								{foreach $tplData.tagRows as $value}
									{if $value.tag_status == "show"}
										{$_css_status = "success"}
									{else}
										{$_css_status = "default"}
									{/if}
									<tr>
										<td class="td_mn"><input type="checkbox" name="tag_id[]" value="{$value.tag_id}" id="tag_id_{$value.tag_id}" group="tag_id" class="chk_all validate"></td>
										<td class="td_mn">{$value.tag_id}</td>
										<td>
											<div>
												{if $value.tag_name}
													{$value.tag_name}
												{else}
													{$lang.label.noname}
												{/if}
											</div>
											<div>
												<a href="{$smarty.const.BG_URL_ADMIN}ctl.php?mod=tag&act_get=list&tag_id={$value.tag_id}">{$lang.href.edit}</a>
											</div>
										</td>
										<td class="td_sm">
											<span class="label label-{$_css_status}">{$status.tag[$value.tag_status]}</span>
										</td>
										<td class="td_sm">{$value.tag_article_count}</td>
									</tr>
								{/foreach}
							</tbody>
							<tfoot>
								<tr>
									<td colspan="2"><span id="msg_tag_id"></span></td>
									<td colspan="3">
										<select name="act_post" id="act_post"  class="validate form-control input-sm">
											<option value="">{$lang.option.batch}</option>
											{foreach $status.tag as $key=>$value}
												<option value="{$key}">{$value}</option>
											{/foreach}
											<option value="del">{$lang.option.del}</option>
										</select>
										<button type="button" id="go_submit" class="btn btn-primary btn-sm">{$lang.btn.submit}</button>
										<span id="msg_act_post"></span>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>

			</form>
		</div>
	</div>

	<div class="text-right">
		{include "include/page.tpl" cfg=$cfg}
	</div>

{include "include/admin_foot.tpl"}

	<script type="text/javascript">
	var opts_validator_list = {
		tag_id: {
			length: { min: 1, max: 0 },
			validate: { type: "checkbox" },
			msg: { id: "msg_tag_id", too_few: "{$alert.x030202}" }
		},
		act_post: {
			length: { min: 1, max: 0 },
			validate: { type: "select" },
			msg: { id: "msg_act_post", too_few: "{$alert.x030203}" }
		}
	};

	var opts_validator_form = {
		tag_name: {
			length: { min: 1, max: 30 },
			validate: { type: "ajax", format: "text" },
			msg: { id: "msg_tag_name", too_short: "{$alert.x130201}", too_long: "{$alert.x130202}", ajaxIng: "{$alert.x030401}", ajax_err: "{$alert.x030402}" },
			ajax: { url: "{$smarty.const.BG_URL_ADMIN}ajax.php?mod=tag&act_get=chkname", key: "tag_name", type: "str", attach: "tag_id={$tplData.tagRow.tag_id}" }
		},
		tag_status: {
			length: { min: 1, max: 0 },
			validate: { type: "radio" },
			msg: { id: "msg_tag_status", too_few: "{$alert.x130204}" }
		}
	};

	var opts_submit_list = {
		ajax_url: "{$smarty.const.BG_URL_ADMIN}ajax.php?mod=tag",
		confirm_id: "act_post",
		confirm_val: "del",
		confirm_msg: "{$lang.confirm.del}",
		btn_text: "{$lang.btn.ok}",
		btn_close: "{$lang.btn.close}",
		btn_url: "{$cfg.str_url}"
	};

	var opts_submit_form = {
		ajax_url: "{$smarty.const.BG_URL_ADMIN}ajax.php?mod=tag",
		btn_text: "{$lang.btn.ok}",
		btn_close: "{$lang.btn.close}",
		btn_url: "{$cfg.str_url}"
	};

	$(document).ready(function(){
		var obj_validate_list = $("#tag_list").baigoValidator(opts_validator_list);
		var obj_submit_list = $("#tag_list").baigoSubmit(opts_submit_list);
		$("#go_submit").click(function(){
			if (obj_validate_list.validateSubmit()) {
				obj_submit_list.formSubmit();
			}
		});
		var obj_validate_form = $("#tag_form").baigoValidator(opts_validator_form);
		var obj_submit_form = $("#tag_form").baigoSubmit(opts_submit_form);
		$("#tag_add").click(function(){
			if (obj_validate_form.validateSubmit()) {
				obj_submit_form.formSubmit();
			}
		});
		$("#tag_list").baigoCheckall();
	})
	</script>

{include "include/html_foot.tpl" cfg=$cfg}

