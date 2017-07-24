{**
 * Настройки профиля
 *}

{component_define_params params=[ 'user' ]}

{* @hook Начало формы с настройками профиля *}
{hook run='user_settings_profile_begin'}

{* Шаблон пользовательского поля (userfield) *}
{function name=userfield}
    <div class="user-field-item js-user-field-item" {if ! $field}id="user-field-template" style="display:none;"{/if}>
        <select name="profile_user_field_type[]">
            {foreach $aUserFieldsContact as $fieldAll}
                <option value="{$fieldAll->getId()}" {if $field && $fieldAll->getId() == $field->getId()}selected{/if}>
                    {$fieldAll->getTitle()|escape}
                </option>
            {/foreach}
        </select>

        <input type="text" name="profile_user_field_value[]" value="{if $field}{$field->getValue()|escape}{/if}" class="ls-width-200">
        {component 'syn-icon' icon='trash' classes='js-user-field-item-remove' attributes=[ title => {lang 'common.remove'} ]}
    </div>
{/function}

{* Скрытое пользовательское поле для вставки через js *}
{* Вынесено за пределы формы, чтобы не передавалось при отправке формы *}
{call userfield field=false}


<form method="post" enctype="multipart/form-data" class="syn-form-panel js-form-validate">
    {hook run='form_settings_profile_begin'}

    {* Основная информация *}

    {* Имя *}
    {component 'field' template='text'
        mods   = 'horizontal'
        name   = 'profile_name'
        rules  = [ 'length' => "[2,{Config::Get('module.user.name_max')}]" ]
        value  = $user->getProfileName()
        label  = {lang name='user.settings.profile.fields.name.label'}}

    {* Пол *}
    {$sex = [
        [ 'value' => 'man',   'text' => {lang name='user.gender.male'} ],
        [ 'value' => 'woman', 'text' => {lang name='user.gender.female'} ],
        [ 'value' => 'other', 'text' => {lang name='user.gender.none'} ]
    ]}

    {component 'field' template='select'
        mods          = 'horizontal'
        name          = 'profile_sex'
        label         = {lang name='user.settings.profile.fields.sex.label'}
        items         = $sex
        selectedValue = $user->getProfileSex()}


    {* Дата рождения *}
    {component 'field' template='date'
        mods         = 'horizontal'
        name         = 'profile_birthday'
        inputClasses = 'js-field-date-default'
        value        = ($user->getProfileBirthday()) ? {date_format date=$user->getProfileBirthday() format='d.m.Y'} : ''
        label        = {lang name='user.settings.profile.fields.birthday.label'}}


    {* О себе *}
    {component 'field' template='textarea'
        name   = 'profile_about'
        rules  = [ 'length' => '[1,3000]' ]
        rows   = 5
        value  = $user->getProfileAbout()
        label  = {lang name='user.settings.profile.fields.about.label'}}


    {* Местоположение *}
    {component 'field' template='geo'
        classes   = 'js-field-geo-default'
        name      = 'geo'
        label     = {lang name='user.settings.profile.fields.place.label'}
        countries = $aGeoCountries
        regions   = $aGeoRegions
        cities    = $aGeoCities
        place     = $oGeoTarget}


    {* Пользовательские поля *}
    {$userfields = $user->getUserFieldValues(false, '')}

    {foreach $userfields as $field}
        {component 'field' template='text'
            name   = "profile_user_field_`$field->getId()`"
            value  = $field->getValue()
            label  = $field->getTitle()|escape}
    {/foreach}


    {* Контакты *}
    <div class="fieldset js-user-fields">
        <header class="fieldset-header">
            <h3 class="fieldset-title">{lang name='user.settings.profile.contact'}</h3>
        </header>

        <div class="fieldset-body">
            {$contacts = $user->getUserFieldValues( true, array('contact', 'social') )}

            {* Список пользовательских полей, шаблон определен в начале файла *}
            <div class="js-user-field-list ls-mb-15">
                {foreach $contacts as $contact}
                    {call userfield field=$contact}
                {foreachelse}
                    {component 'blankslate' classes='js-user-fields-empty' text=$aLang.common.empty}
                {/foreach}
            </div>

            {if $aUserFieldsContact}
                {component 'button' type='button' classes='js-user-fields-submit' text=$aLang.common.add}
            {/if}
        </div>
    </div>

    {* @hook Конец формы с настройками профиля *}
    {hook run='user_settings_profile_end'}

    {* Скрытые поля *}
    {component 'field' template='hidden.security-key'}

    {* Кнопки *}
    {component 'button' mods='primary' text=$aLang.common.save}
</form>

{hook run='settings_profile_end'}