# Forms

``` coffeescript
formFor new User, (form) ->
  form.fieldset "Profile", (fields) ->
    fields.field "firstName"
    fields.field "lastName"
    fields.field "email"
  form.fieldset "Address" do |fields|
    fields.field "lat", as: hidden
    fields.field "lng", as: hidden
    fields.field "street"
    fields.field "city", as: "select", collection: ["CA"]
```

``` html
<form class='form' data-method='post' method='post' novalidate='true' role='form'>
  <fieldset class='fieldset' id='profile'>
    <legend class='legend'>
      <span>Profile</span>
    </legend>
    <ol class='field-list'>
      <li class='field string optional validate'>
        <label class='label' for='active-record-user-first-name-input'>
          <span>First Name</span>
          <abbr class='optional' title='Optional'></abbr>
        </label>
        <input accesskey='f' class='string first-name optional input validate' data-validate='presence' data-validates-presence-message="can't be blank" data-validates-presence='true' id='active-record-user-first-name-input' maxlength='255' name='activeRecordUser[firstName]' type='string' value='Lance' />
        <output class='error'></output>
      </li>
      <li class='field string optional validate'>
        <label class='label' for='active-record-user-last-name-input'>
          <span>Last Name</span>
          <abbr class='optional' title='Optional'></abbr>
        </label>
        <input accesskey='l' class='string last-name optional input validate' data-validate='presence' data-validates-presence-message="can't be blank" data-validates-presence='true' id='active-record-user-last-name-input' maxlength='255' name='activeRecordUser[lastName]' type='string' value='Pollard' />
        <output class='error'></output>
      </li>
      <li class='field email optional validate'>
        <label class='label' for='active-record-user-email-input'>
          <span>Email</span>
          <abbr class='optional' title='Optional'></abbr>
        </label>
        <input accesskey='e' class='email string optional input validate' data-validate='presence' data-validates-presence-message="can't be blank" data-validates-presence='true' id='active-record-user-email-input' maxlength='255' name='activeRecordUser[email]' type='email' value='example@gmail.com' />
        <output class='error'></output>
      </li>
    </ol>
  </fieldset>
  <fieldset class='fieldset' id='address'>
    <legend class='legend'>
      <span>Address</span>
    </legend>
    <ol class='field-list'>
      <li class='field hidden optional'>
        <input accesskey='l' class='hidden lat optional input' id='active-record-user-lat-input' name='activeRecordUser[lat]' type='string' />
      </li>
      <li class='field hidden optional'>
        <input accesskey='l' class='hidden lng optional input' id='active-record-user-lng-input' name='activeRecordUser[lng]' type='string' />
      </li>
      <li class='field string optional'>
        <label class='label' for='active-record-user-street-input'>
          <span>Street</span>
          <abbr class='optional' title='Optional'></abbr>
        </label>
        <input accesskey='s' class='string street optional input' id='active-record-user-street-input' name='activeRecordUser[street]' type='string' />
        <output class='error'></output>
      </li>
      <li class='field select optional'>
        <label class='label' for='active-record-user-city-input'>
          <span>City</span>
          <abbr class='optional' title='Optional'></abbr>
        </label>
        <select accesskey='c' class='select city optional input' id='active-record-user-city-input' name='activeRecordUser[city]'>
          <option value='CA'>CA</option>
        </select>
        <output class='error'></output>
      </li>
    </ol>
  </fieldset>
</form>
```