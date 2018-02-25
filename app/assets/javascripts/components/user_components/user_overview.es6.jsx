class UserOverview extends React.Component {
    render(){
        const { user } = this.props;
        return(
            <div className={"card"}>
                <div className={"card-header"}>
                    <h4 className={"card-title"}>Profile</h4>
                </div>
                <div className={"card-content"}>
                    <div className={"card-body"}>
                        <div className={"row"}>
                            <div className={"card-image col-sm-2"}>
                              <img src={user.avatar_url} alt={user.full_name} />
                            </div>
                            <div className={"card-text col-sm-10"}>
                                <Info user={user} />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        )
    }
}
