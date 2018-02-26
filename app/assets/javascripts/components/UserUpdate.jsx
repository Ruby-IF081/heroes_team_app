class UserUpdate extends React.Component {
  constructor(props) {
    super(props);
    this.state = {  
      user: this.props.user
    };

    this.handleFirstNameChange = this.handleFirstNameChange.bind(this);
    this.handleLastNameChange = this.handleLastNameChange.bind(this);
    this.handleEmailChange = this.handleEmailChange.bind(this);
    this.handleRoleChange = this.handleRoleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleFirstNameChange(e) {
    let newUserValue = this.state.user;
    newUserValue.first_name = e.target.value;
    this.setState({user: newUserValue});
  }

  handleLastNameChange(e) {
    let newUserValue = this.state.user;
    newUserValue.last_name = e.target.value;
    this.setState({user: newUserValue});
  }

  handleEmailChange(e) {
    var newUserValue = this.state.user;
    newUserValue.email = e.target.value;
    this.setState({employee: newUserValue});
  }

  handleRoleChange(e) {
    let newUserValue = this.state.user;
    newUserValue.role = e.target.value;
    this.setState({user: newUserValue});
  }
  
  handleSubmit(event) {
    event.preventDefault();
    const data = new FormData(event.target);
    const token = this.props.csrf_token;
    const url = '/account/users/'+this.props.user.id;
    fetch(url, {
      method: 'PUT',
      headers: { 'X-CSRF-Token': token, 
                 'Content-Type': 'application/json' },
      credentials: 'same-origin',  
      body: JSON.stringify({ "user": {
                               "id": this.state.user.id,
                               "first_name" : this.state.user.first_name,
                               "last_name" : this.state.user.last_name,
                               "email" : this.state.user.email,
                               "role" : this.state.user.role
                              }
                            }),
    });
  }

  render(){

    return (
      <form onSubmit={this.handleSubmit}
            noValidate="novalidate" 
            className="simple_form edit_user" 
            id={"edit_user_"+this.props.user.id} 
            action={'/account/users/'+this.props.user.id} 
            acceptCharset="UTF-8" 
            method="post">
        <input name="utf8" value="✓" type="hidden"/>
        <input name="_method" value="patch" type="hidden"/>
        <input name="authenticity_token" 
               value={this.props.csrf_token}
               type="hidden"/>
        <div className="form-group string required user_first_name">
          <label className="control-label string required" 
                 htmlFor="user_first_name"><abbr title="required">*</abbr>
           First name
          </label>
          <input onChange={this.handleFirstNameChange} 
                 className="form-control string required form-control" 
                 autoFocus="autofocus" 
                 value={this.state.user.first_name} 
                 name="first_name" 
                 id="user_first_name" 
                 type="text"
          />
        </div>
        <div className="form-group string required user_last_name">
          <label className="control-label string required" htmlFor="user_last_name"><abbr title="required">*</abbr> 
            Last name
          </label>
          <input onChange={this.handleLastNameChange} 
                 className="form-control string required form-control" 
                 value={this.state.user.last_name} 
                 name="last_name" 
                 id="user_last_name" 
                 type="text"
          />
        </div>
        <div className="form-group email required user_email">
          <label className="control-label email required" htmlFor="user_email"><abbr title="required">*</abbr>
            Email
          </label>
          <input onChange={this.handleEmailChange} className="form-control string email required form-control" 
                 value={this.state.user.email} name="email" id="user_email" type="email"
          />
          </div>
        <div className="form-group select required user_role">
          <label className="control-label select required" htmlFor="user_role"><abbr title="required">*</abbr> 
            Role
          </label>
          <select value={this.state.user.role} 
                  onChange={this.handleRoleChange} 
                  className="form-control select required form-control" 
                  name="role" id="user_role">
            <option>sale</option>
            <option>admin</option>
          </select>
        </div>
        <input name="commit" 
               value="Edit" 
               className="btn btn-default btn btn-primary" 
               data-disable-with="Edit" 
               type="submit"/>
      </form>
    )
  }
}