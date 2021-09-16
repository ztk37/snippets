import { Form, Formik, useField } from "formik";

const TextField = ({
  name,
  label,
  type
}: {
  name: string;
  label: string;
  type: string;
}) => {
  const [field, meta, helpers] = useField({ name });

  console.log("field:", field);
  console.log("meta:", meta);
  console.log("helpers:", helpers);

  return (
    <div>
      <label htmlFor={name}>
        {label}
        <input {...field} type={type} name={name} placeholder={name} />
      </label>
      {meta.touched && meta.error ? <div>{meta.error}</div> : null}
    </div>
  );
};

TextField.defaultProps = {
  type: "text"
};

const LoginForm = () => {
  const handleSubmit = (values: { a: string; b: string; c: string }) => {
    console.log(values);
  };

  return (
    <Formik initialValues={{ a: "", b: "", c: "" }} onSubmit={handleSubmit}>
      <Form>
        <TextField name="a" label="A" />
        <TextField name="b" label="B" />
        <TextField name="c" label="C" />
        <button type="submit">Login</button>
      </Form>
    </Formik>
  );
};

export default LoginForm;
