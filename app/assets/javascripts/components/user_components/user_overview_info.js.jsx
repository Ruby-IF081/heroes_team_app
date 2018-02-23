function Info(props) {
        return (
            <div className={"row col-sm-10"}>
                <div className={"card-text col-sm-2"}><h6>Full name:</h6></div>
                <div className={"card-text col-sm-10"}>
                    <p>{props.user.full_name}</p>
                </div>
                <div className={"card-text col-sm-2"}><h6>User-email:</h6></div>
                <div className={"card-text col-sm-10"}>
                    <p>{props.user.email}</p>
                </div>
                <div className={"card-text col-sm-2"}><h6>Role:</h6></div>
                <div className={"card-text col-sm-10"}>
                    <p>{props.user.role}</p>
                </div>
                <div className={"card-text col-sm-2"}><h6>Created at:</h6></div>
                <div className={"card-text col-sm-10"}>
                    <p>{props.user.created_at}</p>
                </div>
                <div className={"card-text col-sm-2"}><h6>Tenant:</h6></div>
                <div className={"card-text col-sm-10"}>
                    <p>{props.user.tenant_name}</p>
                </div>
            </div>
        );
}