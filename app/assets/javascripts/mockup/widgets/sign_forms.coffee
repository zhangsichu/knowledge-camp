@SignInForm = React.createClass
  getInitialState: ->
    email: ''
    password: ''
    error: null

  render: ->
    <div className='sign-in-form ui form' ref='form'>
      <div className='field'>
        <div className='ui left icon input'>
          <i className='icon mail' />
          <input type='text' placeholder='邮箱' value={@state.email} onChange={@on_change('email')} />
        </div>
      </div>

      <div className='field'>
        <div className='ui left icon input'>
          <i className='icon asterisk' />
          <input type='password' placeholder='密码' value={@state.password} onChange={@on_change('password')}/>
        </div>
      </div>

      {
        if @state.error
          <div className="ui yellow message small">
            <i className='icon info circle' />{@state.error}
          </div>
      }

      <div className='field'>
        <a className='ui button fluid green large' onClick={@do_submit}>登录</a>
      </div>

      {
        if false
          <div className='field'>
            <a href='javascript:;'>我忘记密码了</a>
          </div>
      }
    </div>

  on_change: (input_name)->
    (evt)=>
      @setState "#{input_name}": evt.target.value

  do_submit: ->
    # 登录
    data =
      user:
        email: @state.email
        password: @state.password
        remember_me: true

    jQuery.ajax
      url: @props.submit_url
      type: "POST"
      data: data
      dataType: "json"
      success: (res)=>
        console.log res
        if @props.jump
          Turbolinks.visit @props.jump
        else
          location.reload()

      statusCode: 
        401: (res)=>
          @setState
            error: res.responseJSON?.error
        
@SignUpForm = React.createClass
  getInitialState: ->
    name: ''
    email: ''
    password: ''

    errors: null

  render: ->
    <div className='sign-up-form ui form' ref='form'>
      <div className='field'>
        <div className='ui left icon input'>
          <i className='icon user' />
          <input type='text' placeholder='用户名' value={@state.name} onChange={@on_change('name')} />
        </div>
      </div>

      <div className='field'>
        <div className='ui left icon input'>
          <i className='icon mail' />
          <input type='text' placeholder='注册邮箱' value={@state.email} onChange={@on_change('email')} />
        </div>
      </div>

      <div className='field'>
        <div className='ui left icon input'>
          <i className='icon asterisk' />
          <input type='password' placeholder='登录密码' value={@state.password} onChange={@on_change('password')} />
        </div>
      </div>
      {
        if @state.errors
          <div className="ui yellow message small">
          {
            for key, value of @state.errors
              <div key={key}><i className='icon info circle' />{value[0]}</div>
          }
          </div>
          

      }

      <div className='field'>
        <a className='ui button fluid green large' onClick={@do_submit}>我要注册</a>
      </div>
    </div>

  on_change: (input_name)->
    (evt)=>
      @setState "#{input_name}": evt.target.value

  do_submit: ->
    # 注册

    data =
      user:
        name: @state.name
        email: @state.email
        password: @state.password

    jQuery.ajax
      url: @props.submit_url
      type: "POST"
      data: data
      dataType: "json"
      success: (res)->
        console.log res
        location.reload()
      statusCode:
        422: (res)=>
          @setState
            errors: res.responseJSON?.errors