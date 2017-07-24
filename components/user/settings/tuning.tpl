{**
 * Настройка уведомлений
 *}

{* @hook Начало формы с настройками уведомлений *}
{hook run='user_settings_tuning_begin'}

<form action="{router page='settings'}tuning/" method="POST" enctype="multipart/form-data" class="syn-form-panel">
    {hook run='form_settings_tuning_begin'}

    {component 'field' template='hidden.security-key'}

    <h3>{lang name='user.settings.tuning.email_notices'}</h3>

    <div class="ls-field-checkbox-group">
        {component 'field' template='checkbox'
                 name     = 'settings_notice_new_topic'
                 checked  = $oUserCurrent->getSettingsNoticeNewTopic() != 0
                 noMargin = true
                 label    = {lang name='user.settings.tuning.fields.new_topic'}}

        {component 'field' template='checkbox'
                 name     = 'settings_notice_new_comment'
                 checked  = $oUserCurrent->getSettingsNoticeNewComment() != 0
                 noMargin = true
                 label    = {lang name='user.settings.tuning.fields.new_comment'}}

        {component 'field' template='checkbox'
                 name     = 'settings_notice_new_talk'
                 checked  = $oUserCurrent->getSettingsNoticeNewTalk() != 0
                 noMargin = true
                 label    = {lang name='user.settings.tuning.fields.new_talk'}}

        {component 'field' template='checkbox'
                 name     = 'settings_notice_reply_comment'
                 checked  = $oUserCurrent->getSettingsNoticeReplyComment() != 0
                 noMargin = true
                 label    = {lang name='user.settings.tuning.fields.reply_comment'}}

        {component 'field' template='checkbox'
                 name     = 'settings_notice_new_friend'
                 checked  = $oUserCurrent->getSettingsNoticeNewFriend() != 0
                 noMargin = true
                 label    = {lang name='user.settings.tuning.fields.new_friend'}}
    </div>

    <h3>{lang name='user.settings.tuning.general'}</h3>

    {foreach $aTimezoneList as $timezone}
        {$timezoneLang=$aLang.date.timezones[ $timezone ]}
        {if $timezoneLang}
            {$timezones[] = [
                'value' => $timezone,
                'text' => $timezoneLang
            ]}
        {/if}
    {/foreach}

    {component 'field' template='select'
             name          = 'settings_general_timezone'
             label         = {lang name='user.settings.tuning.fields.timezone.label'}
             items         = $timezones
             selectedValue = $_aRequest.settings_general_timezone}

    {* @hook Конец формы с настройками уведомлений *}
    {hook run='user_settings_tuning_end'}

    {component 'button' text=$aLang.common.save mods='primary'}
</form>

{hook run='settings_tuning_end'}